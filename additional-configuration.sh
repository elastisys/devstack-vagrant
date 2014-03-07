#!/bin/bash

# Get the OpenStack credentials (for "demo" user)
source /home/vagrant/devstack/openrc

echo "--- Creating key for VMs (accessible in devstack-vagrant directory)"
nova keypair-add heat_key > /vagrant/heat_key.priv
chmod 600 /vagrant/heat_key.priv
ln -s /vagrant/heat_key.priv /home/vagrant/heat_key.priv

echo "--- Making default security group less restrictive"
# - permit ICMP (like ping)
nova secgroup-add-rule default icmp -1 -1 0.0.0.0/0
# - permit ssh
nova secgroup-add-rule default tcp 22 22 0.0.0.0/0
# - permit web
nova secgroup-add-rule default tcp 80 80 0.0.0.0/0

echo "--- Ensuring that VMs can access the Internet"
sudo echo 1 > /proc/sys/net/ipv4/ip_forward
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
