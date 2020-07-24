#!/bin/sh

terraform_version="0.12.29"
terraform_pkg="terraform_${terraform_version}_linux_amd64.zip"
terraform_bin=$HOME/bin

mkdir -p ${terraform_bin} # NOTE: $HOME/bin is already part of the standard .profile

sudo apt-get install -y unzip

wget https://releases.hashicorp.com/terraform/${terraform_version}/${terraform_pkg}
unzip ./${terraform_pkg}
mv terraform ${terraform_bin}
rm ./${terraform_pkg}

