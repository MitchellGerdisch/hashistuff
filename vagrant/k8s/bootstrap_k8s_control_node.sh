#!/bin/bash

# Heavily based on: https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/

echo "**** Provisioning k8s control plane node"


IP_ADDR=${1}
HOST_NAME=$(hostname -s)                                                       
sudo kubeadm init --control-plane-endpoint $IP_ADDR --apiserver-advertise-address=$IP_ADDR --apiserver-cert-extra-sans=$IP_ADDR  --node-name $HOST_NAME --pod-network-cidr=10.244.0.0/16
#sudo kubeadm init --control-plane-endpoint ${1} --pod-network-cidr=10.244.0.0/16

# Get the join info so that the worker nodes can join the cluster
discovery_token=`openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | openssl rsa -pubin -outform der 2>/dev/null | openssl dgst -sha256 -hex | sed 's/^.* //'`

# create a new token and join command 
join_command=`sudo kubeadm token create --print-join-command 2> /dev/null`

# drop it in the shared vagrant directory so the worker nodes can access it
join_command_script="/vagrant/join_command.sh"
echo "sudo ${join_command}" > ${join_command_script}
chmod 755 ${join_command_script}

# Configure kubectl for use by non-root
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Install network pod
kubectl apply -f /vagrant/calico.yaml

echo "***** VM, ${HOSTNAME} k8s control node provisioning completed"
