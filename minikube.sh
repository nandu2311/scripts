#!/bin/bash

sudo su
sudo apt-get update -y
sudo apt-get install docker.io -y

#download kubectl and install it

curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && chmod +x ./kubectl && sudo mv ./kubectl /usr/local/bin/kubectl

#downloading minikube and configuring

curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64

mv minikube-linux-amd64 minikube

chmod +x minikube

sudo mv minikube /usr/local/bin

sudo apt-get install conntrack
sudo minikube start --vm-driver=none
minikube status
kubectl version