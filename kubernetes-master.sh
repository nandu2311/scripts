#!/bin/bash

sudo apt-get update -y
sudo apt-get install apt-transport-https
sudo apt-get install docker.io -y
sudo docker --version
sudo systemctl start docker
sudo systemctl enable docker 

sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add

echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" >> /etc/apt/source.list.d/kubernetes.list

sudo apt-get update -y

sudo apt-get install -y kubelet kubectl kubeadm kubernetes-cni

mkdir -p $HOME/.kube

cp -i /etc/kubernetes/admin.conf $HOME./kube/config

chown $(id -u):$(id -g) $HOME/.kube/config

kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/v0.8.0/Documentation/kube-flannel-rbac.yml


