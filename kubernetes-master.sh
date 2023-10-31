#!/bin/bash

sudo apt update -y
sudo apt install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common
    export OS_VERSION=xUbuntu_22.04
    export CRIO_VERSION=1.24
sudo curl -fsSL https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/$OS_VERSION/Release.key | sudo gpg --dearmor -o /usr/share/keyrings/libcontainers-archive-keyring.gpg
sudo curl -fsSL https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable:/cri-o:/$CRIO_VERSION/$OS_VERSION/Release.key | sudo gpg --dearmor -o /usr/share/keyrings/libcontainers-crio-archive-keyring.gpg
sudo echo "deb [signed-by=/usr/share/keyrings/libcontainers-archive-keyring.gpg] https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/$OS_VERSION/ /" | sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list
sudo echo "deb [signed-by=/usr/share/keyrings/libcontainers-crio-archive-keyring.gpg] https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable:/cri-o:/$CRIO_VERSION/$OS_VERSION/ /" | sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable:cri-o:$CRIO_VERSION.list
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
sudo echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y cri-o cri-o-runc kubelet=1.24.2-00 kubeadm=1.24.2-00 kubectl=1.24.2-00
sudo systemctl daemon-reload
sudo systemctl enable crio
sudo systemctl start crio
sudo apt-mark hold cri-o kubelet kubeadm kubectl
cat <<EOF | sudo tee /etc/modules-load.d/containerd.conf
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter
cat <<EOF | sudo tee /etc/sysctl.d/kubernetes.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

sudo sysctl --system

sudo kubeadm init --pod-network-cidr=192.168.0.0/16

### After run getting error CRI run this command: 

echo "rm /etc/containerd/config.toml"

echo "systemctl restart containerd"


mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

#wget https://github.com/flannel-io/flannel/releases/latest/download/kube-flannel.yml

#echo "kube-flannel edit this file and change cidr to 192.168.0.0/16"

echo "wget https://raw.githubusercontent.com/projectcalico/calico/v3.24.1/manifests/calico.yaml"

# export KUBECONFIG=/etc/kubernetes/admin.conf


