#!/bin/sh

echo "***** DEBUG  Starting script as $USER"

#####
# This script sets up a VM so it can run minikube and kubectl and helm.
# It sets things up so minikube uses the docker driver so that minikube will run on  VM.
#####

sudo apt update 

echo "***** DEBUG  docker install"
### docker installation/setup ###

sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common 
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable" 

sudo apt-get update 
sudo apt-get install -y docker-ce docker-ce-cli containerd.io 

# Add me as a privileged docker user
sudo usermod -aG docker $USER && newgrp docker

## end docker installation/setup 

echo "***** DEBUG  minikube install"
### minikube installation ###

curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 2>/dev/null
chmod +x minikube
sudo mv minikube /usr/bin

# set some defaults
minikube config set vm-driver docker
minikube config set cpus 2

## end minikube installation

echo "***** DEBUG  kubectl install"
### install kubectl ###
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl 2> /dev/null
chmod +x ./kubectl
sudo mv ./kubectl /usr/bin/kubectl
## end kubectl install

echo "***** DEBUG  helm install"
### start helm install ###
curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get > get_helm.sh
chmod 700 get_helm.sh
./get_helm.sh 2> /dev/null
echo "***** DEBUG helm init"
helm init

echo "***** DEBUG minikube start"
echo "***** DEBUG This may take some time ...."
# Start up minikube cluster
minikube start 2> /dev/null

echo "***** DEBUG script done"
