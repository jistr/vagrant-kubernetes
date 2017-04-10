#!/bin/bash

if type dnf &> /dev/null; then
    PACKAGE_MANAGER=dnf
    PACKAGES="libselinux-python python python2-dnf"
else
    PACKAGE_MANAGER=yum
    PACKAGES="libselinux-python python"
fi

sudo $PACKAGE_MANAGER -y install $PACKAGES

if ! sudo test -e /root/.ssh/authorized_keys; then
    sudo mkdir -p /root/.ssh
    sudo cp /home/vagrant/.ssh/authorized_keys /root/.ssh/authorized_keys
    sudo chmod -R go-rwx /root/.ssh
fi
