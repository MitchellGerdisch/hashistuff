#!/bin/bash

# Heavily based on: https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/

echo "**** Provisioning k8s worker node"

# execute join command found in /vagrant that was created by controller node
join_command_script="/vagrant/join_command.sh"
${join_command_script}


echo "***** VM, ${HOSTNAME} k8s worker node provisioning completed"
