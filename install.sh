#!/usr/bin/env bash
# install requirements
sudo apt install git git-lfs
git lfs install

# install ssh keys
cd .ssh
bash install_ssh_keys.sh
echo "SSH keys installed"

# copy config
cd ..
cp config-sample.conf config.conf
echo "config created, edit it for your needs"

mkdir sync
