#!/bin/bash

set -eu

# generate inventory
echo '[masters]' > ansible-inventory
vagrant status | grep '(libvirt)' | grep master | awk '{ print $1 }' >> ansible-inventory
echo '[nodes]' >> ansible-inventory
vagrant status | grep '(libvirt)' | grep node | awk '{ print $1 }' >> ansible-inventory

vagrant ssh-config | sed -e 's/User vagrant/User root/' > ansible-ssh-config

# move to playbooks/configure.yml and remove the symlink when
# https://github.com/ansible/ansible/issues/17869 is fixed
ansible-playbook -i ansible-inventory "$@" configure-kubeadm.yml
