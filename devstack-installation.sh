#!/bin/bash

echo "--- Updating apt sources and installing git" 
sudo apt-get update
sudo apt-get install git -y

echo "--- Cloning DevStack repo"
git clone https://github.com/openstack-dev/devstack.git /home/vagrant/devstack

echo "--- Linking DevStack settings (local.conf)"
ln -s /vagrant/local.conf /home/vagrant/devstack/local.conf

echo "--- Installing DevStack"
cd /home/vagrant/devstack
./stack.sh
