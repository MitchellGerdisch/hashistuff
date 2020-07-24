#!/bin/bash

# Heavily based on: https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/

echo "**** Provisioning base k8s on VM ${HOSTNAME}"

# get things updated to start
sudo apt-get update 

# Make sure access is allowed betweeen nodes
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sudo sysctl --system

# Disable swap - required for kubernetes
sudo sed -i '/swap/d' /etc/fstab
sudo swapoff -a

echo "**** INSTALLING DOCKER"
sudo apt-get install -y docker.io
sudo systemctl enable docker
sudo systemctl start docker

echo "**** INSTALLING k8s"
sudo apt-get update && sudo apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

echo "***** INSTALLING helm 3"
### 
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh 2> /dev/null

echo "***** VM, ${HOSTNAME} k8s base provisioning completed"
