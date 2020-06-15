#!/bin/bash

echo "**** Provisioning k3s on VM ${HOSTNAME}"

echo "**** INSTALLING k3s"
###
curl -sfL https://get.k3s.io | sh -
sudo chmod 644 /etc/rancher/k3s/k3s.yaml
echo "export KUBECONFIG=/etc/rancher/k3s/k3s.yaml" >> $HOME/.profile

echo "***** INSTALLING helm"
### 
curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get 1> get_helm.sh 2> /dev/null
chmod 700 get_helm.sh
./get_helm.sh 2> /dev/null
helm init

echo "***** Setting up tiller user for helm."
kubectl --namespace kube-system create serviceaccount tiller
kubectl create clusterrolebinding tiller --clusterrole cluster-admin --serviceaccount=kube-system:tiller
helm init --service-account tiller --upgrade

echo "***** VM, ${HOSTNAME} k3s provisioning completed"
