locals {
    instance_type = "t2.micro" 
    ami = "ami-0e001c9271cf7f3b9" #(Ubuntu 20.04)
    key_pem_name = "docker" 
    security_groups = ["sg-0cb30a03c83bfb281"] 
    subnet_id = "subnet-05743d3bc4c8320a4" 
    pem_route = "~/git/pems/docker.pem" 
}

provider "aws" {
    region     = "us-east-1"
    access_key = "${access_key}"
    secret_key = "${secret_key}"
}

resource "aws_instance" "docker-Services" {
    ami = local.ami
    instance_type = local.instance_type
    key_name = local.key_pem_name
    security_groups = local.security_groups
    subnet_id = local.subnet_id
    associate_public_ip_address = true
    tags = {
        Name = "docker-Service"
    }

}

resource "aws_eip_association" "eip_assoc" {
    instance_id   = aws_instance.docker-Services.id
    allocation_id = "eipalloc-075b24302911ba3f4"
    depends_on = [ aws_instance.docker-Services ]
}

resource "null_resource" "post_setup" {
    
    connection {
        type        = "ssh"
        user        = "ubuntu"
        private_key = file(local.pem_route)
        host        = aws_eip_association.eip_assoc.public_ip
    }

    provisioner "file" {
        source      = "install.sh"
        destination = "/tmp/install.sh"
    }

    provisioner "file" {
        source      = "../traefik/docker-compose.yml"
        destination = "/home/ubuntu/docker-compose.yml"
    }

    provisioner "remote-exec" {
        inline = [
            "sudo chmod +x /tmp/install.sh",
            "sudo bash /tmp/install.sh"
        ]
    }

    provisioner "remote-exec" {
        inline = [
            "sudo docker compose -f ~/docker-compose.yml up -d",
        ]
    }

    depends_on = [aws_eip_association.eip_assoc]
}