#!/bin/sh

# Installs terraform

terraform_version="0.12.29"
terraform_pkg="terraform_${terraform_version}_linux_amd64.zip"
terraform_bin=$HOME/bin

mkdir -p ${terraform_bin} 

sudo apt-get install -y unzip

wget https://releases.hashicorp.com/terraform/${terraform_version}/${terraform_pkg}  2> /dev/null
unzip ./${terraform_pkg} 
mv terraform ${terraform_bin}
rm ./${terraform_pkg}

# set up path
echo "PATH=\$PATH:${terraform_bin}" >> $HOME/.profile
. ./.profile

# Enable autocomplete
terraform -install-autocomplete
