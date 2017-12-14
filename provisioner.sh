#!/bin/bash

# This script would configure and run the UserManager application in
# Docker containers when run on any Linux machine.

install_docker() {
  docker -v > /dev/null
  if [[ $? -eq 0 ]]; then
    echo "Docker is already installed."
  else
    echo "Installing docker"
    sudo apt-get update
    sudo apt-get install \
      apt-transport-https \
      ca-certificates \
      curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo apt-key fingerprint 0EBFCD88
    sudo add-apt-repository \
      "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) \
      stable"
    sudo apt-get update
    sudo apt-get install -y docker-ce
  fi
  return 0
}

setup_docker_compose() {
  docker-compose -v > /dev/null
  if [[ $? -eq 0 ]]; then
    echo "docker-compose is already setup"
  else
    echo "Setting up docker-compose"
    sudo curl -L https://github.com/docker/compose/releases/download/1.17.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    echo "docker-compose setup completed"
  fi
  return 0
}

setup_repo() {
  echo "Setting up Repo"
  if [[ ! -d /home/ubuntu/UserManager ]]; then
    cd /home/ubuntu
    git clone https://github.com/andela-ifatoki/UserManager.git
  fi
  cd /home/ubuntu/UserManager
  git pull
  echo "Repo Setup Completed"
}

setup_environment() {
  touch .env
  echo -e "PORT=3000\nDB_URL='mongodb://mongodb:27017/user_db'\n" > .env
}

start_docker() {
  sudo docker build -t user_manager_app .
  sudo docker-compose up
}

main() {
  install_docker
  setup_docker_compose
  setup_repo
  setup_environment
  start_docker
}

main