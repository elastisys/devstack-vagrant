# devstack-vagrant

Quick and easy way to set up DevStack using Vagrant with no external dependencies or other technologies to understand.

## Required software
- [Vagrant](http://www.vagrantup.com/) (tested using 1.4.3, configuration file syntax should be valid until version 2 comes out)
- [VirtualBox](https://www.virtualbox.org/) (tested using 4.2.22, any version compatible with your Vagrant should work fine)

## Usage

1. `git clone https://github.com/elastisys/devstack-vagrant.git && cd devstack-vagrant`
2. `$EDITOR local.conf # configure DevStack to your liking`
3. `vagrant up # now get a cup of coffee, it will take a while`
4. From within the VM: `./additional-configuration.sh # sets up networking, creates a private key, etc.`

If you want to fix something, run commands directly within the DevStack VM, or have made changes to `local.conf` (which you can do right from the host machine, since the file is linked in the VM), ssh in using `vagrant ssh`. You will be logged in as the unprivileged user that installed DevStack and have full control over it.

## What it does

The idea is very simple:

1. Using an unprivileged user (but who has `sudo` rights), we first obtain a fresh install of git.
2. We clone the [devstack repo](https://github.com/openstack-dev/devstack.git).
3. We link the `local.conf` file that is in the current directory (which is shared into the VM by Vagrant to the `/vagrant` mount point) to the devstack directory.
4. We run the devstack `stack.sh` script.
5. The VM is configured to connect to a NAT, and its port 80 is forwarded to your host machine's port 3180, so you can access the Horizon web interface by visiting [localhost:3180](http://localhost:3180/). The DevStack VM can connect to the VMs it creates using the local 10.0.0.0 network, and you should be able to assign floating IPs that will make the internal VMs reachable from also your host machine.
6. We create a private key for usage with Heat, and it winds up in both the home directory of the DevStack VM vagrant user, and in your project directory (the one containing the Vagrantfile on your host machine). This is done in the `additional-configuration.sh` script.

The beauty of this approach is that it matches (almost?) exactly what you would do manually, and automates just enough to let you focus on the interesting part ([editing local.conf](http://devstack.org/configuration.html) to your liking).
