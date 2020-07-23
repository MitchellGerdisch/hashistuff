#!/bin/bash

### Currently, not working.
### Launches the consul pods but they get stuck and never come up.
### Have not dug into the problem yet.


# Get consul binary simply to be able to do keygen to set up gossip secret
sudo apt install -y unzip
cd /tmp
curl -fsSL -o consul.zip  https://releases.hashicorp.com/consul/1.7.4/consul_1.7.4_linux_amd64.zip
unzip ./consul.zip

# create the secret used for the gossip encryption
# this key name matches the consul_primary.yaml file
kubectl create secret generic consul-gossip-encryption-key --from-literal=key=$(./consul keygen)


# Add consul helm chart
helm repo add hashicorp https://helm.releases.hashicorp.com

# install consul using config.yaml
helm install consul hashicorp/consul --set global.name=consul -f consul_primary.yaml





