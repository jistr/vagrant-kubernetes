#!/bin/bash

sudo yum -y install libselinux-python python
sudo mkdir -p /root/.ssh
sudo cp /home/vagrant/.ssh/authorized_keys /root/.ssh/authorized_keys
sudo chmod -R go-rwx /root/.ssh
