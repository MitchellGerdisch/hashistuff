#!/bin/sh

#####
# This script sets up a VM so it can run minikube and kubectl and helm.
# It sets things up so minikube uses the docker driver so that minikube will run on  VM.
#####

sudo apt update > /dev/null

### start docker installation/setup ###
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common > /dev/null
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable" > /dev/null

sudo apt-get update > /dev/null
sudo apt-get install -y docker-ce docker-ce-cli containerd.io > /dev/null

# Add me as a privileged docker user
sudo usermod -aG docker $USER && newgrp docker

## end docker installation/setup 

### start minikube installation ###

curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 > /dev/null
chmod +x minikube
sudo mv minikube /usr/bin

# set some defaults
minikube config set vm-driver docker
minikube config set cpus 1

## end minikube installation

### start install kubectl ###
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl > /dev/null
chmod +x ./kubectl
sudo mv ./kubectl /usr/bin/kubectl
## end kubectl install

### start helm install ###
curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get > get_helm.sh
chmod 700 get_helm.sh
./get_helm.sh
helm init


# Start up minikube cluster
minikube start 
