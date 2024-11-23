#!/bin/bash

## INSTALL DOCKER ##
  sudo apt-get update -y
  sudo apt-get install ca-certificates curl -y
  sudo install -m 0755 -d /etc/apt/keyrings
  sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
  sudo chmod a+r /etc/apt/keyrings/docker.asc

  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt-get update -y 
  sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

# create docker network for traefik
  sudo docker network create traefik-net

# create folder for traefik configuration and certificates letsencrypt
  mkdir -p ./letsencrypt
  touch ./letsencrypt/acme.json
  chmod 600 ./letsencrypt/acme.json

# Login to Docker Hub
  export DOCKER_USERNAME=${docker_username}
  export DOCKER_PASSWORD=${docker_password}
  sudo docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD