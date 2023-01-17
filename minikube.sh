#!/bin/bash

sudo su
sudo apt-get update -y
sudo apt-get install docker.io -y
sudo apt-get install conntrack
sudo minikube start --vm-driver=none
minikube status
kubectl version