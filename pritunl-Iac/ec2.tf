locals {
    instance_type = "t2.micro" 
    ami = "ami-0866a3c8686eaeeba" #(Ubuntu 24.04)
    key_pem_name = "pritunl-vpn" 
    security_groups = ["sg-0a2b8350855c35a3d"] 
    subnet_id = "subnet-05743d3bc4c8320a4" 
    pem_route = "~/git/pems/pritunl-vpn.pem" 
}

provider "aws" {
    region     = "us-east-1"
    access_key = "${aws_access_key}"
    secret_key = "${aws_secret_key}"
}

resource "aws_eip_association" "eip_assoc" {
    instance_id   = aws_instance.pritunl-server.id
    allocation_id = "eipalloc-081dab01b59b954d3"
    depends_on = [ aws_instance.pritunl-server ]
}

resource "aws_instance" "pritunl-server" {
    ami = local.ami
    instance_type = local.instance_type
    key_name = local.key_pem_name
    security_groups = local.security_groups
    subnet_id = local.subnet_id
    associate_public_ip_address = true
    tags = {
        Name = "pritunl-server"
    }
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

    provisioner "remote-exec" {
        inline = [
            "sudo chmod +x /tmp/install.sh",
            "sudo bash /tmp/install.sh"
        ]
    }

}