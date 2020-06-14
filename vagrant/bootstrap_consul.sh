#!/bin/sh

consul_zip="consul_1.7.4_linux_amd64.zip"
consul_download = "https://releases.hashicorp.com/consul/1.7.4/${consul_zip}"

sudo apt update
sudo apt install unzip
wget ${consul_download}
unzip ./${consul_zip}
sudo mv consul /usr/bin/
rm ${consul_zip}
