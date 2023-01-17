# #!/bin/bash

#!/bin/bash
# last minute patch, added 20 Aug. 2021
# currently only supported on Ubuntu 20.04 LTS

sudo apt-get update -y
sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update -y
sudo apt-get install docker-ce docker-ce-cli containerd.io -y

curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
####
echo the script is now ready
echo manually run minikube start --vm-driver=docker to start minikube

sudo usermod -aG docker $USER
newgrp docker

minikube start --vm-driver=docker --cni=calico
















##This is Very Dificult Steps to install minikube###
# sudo apt-get update -y
# sudo apt install -y apt-transport-https

# sudo apt-get install ca-certificates curl gnupg lsb-release -y

# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# echo \
# "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
# $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# sudo apt-get update -y

# sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y

# sudo groupadd docker

# sudo usermod -aG docker $USER

# sudo systemctl enable docker

# sudo systemctl status docker

# git clone https://github.com/Mirantis/cri-dockerd.git

# # Run these commands as root
# ###Install GO###
# wget https://storage.googleapis.com/golang/getgo/installer_linux
# chmod +x ./installer_linux
# ./installer_linux
# source ~/.bash_profile

# cd cri-dockerd
# mkdir bin
# go build -o bin/cri-dockerd
# mkdir -p /usr/local/bin
# install -o root -g root -m 0755 bin/cri-dockerd /usr/local/bin/cri-dockerd
# cp -a packaging/systemd/* /etc/systemd/system
# sed -i -e 's,/usr/bin/cri-dockerd,/usr/local/bin/cri-dockerd,' /etc/systemd/system/cri-docker.service
# systemctl daemon-reload
# systemctl enable cri-docker.service
# systemctl enable --now cri-docker.socket


# # sudo apt-get install docker.io -y


# #download kubectl and install it

# sudo curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && chmod +x ./kubectl && sudo mv ./kubectl /usr/local/bin/kubectl

# #downloading minikube and configuring

# sudo curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64

# sudo mv minikube-linux-amd64 minikube

# sudo chmod +x minikube

# sudo mv minikube /usr/local/bin

# sudo apt-get install conntrack

# # sudo minikube start --vm-driver=none

# # git clone https://github.com/kubernetes-sigs/cri-tools.git

# VERSION="v1.26.0"
# wget https://github.com/kubernetes-sigs/cri-tools/releases/download/$VERSION/crictl-$VERSION-linux-amd64.tar.gz
# sudo tar zxvf crictl-$VERSION-linux-amd64.tar.gz -C /usr/local/bin
# rm -f crictl-$VERSION-linux-amd64.tar.gz

# sudo chmod 666 /var/run/docker.sock

# minikube start --driver=none

# minikube status
# kubectl version

# kubectl patch nodes minikube --patch '{"spec":{"unschedulable": false}}'