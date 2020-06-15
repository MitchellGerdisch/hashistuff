#!/bin/bash

echo "**** Provisioning k3s on VM ${HOSTNAME}"

echo "**** INSTALLING k3s"
###
curl -sfL https://get.k3s.io | sh -
sudo chmod 644 /etc/rancher/k3s/k3s.yaml
echo "export KUBECONFIG=/etc/rancher/k3s/k3s.yaml" >> $HOME/.profile

echo "***** INSTALLING helm 3"
### 
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh 2> /dev/null

echo "***** VM, ${HOSTNAME} k3s provisioning completed"
