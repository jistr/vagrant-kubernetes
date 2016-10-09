#!/bin/bash

set -eu

# generate inventory
echo '[masters]' > ansible-inventory
vagrant status | grep '(libvirt)' | grep master | awk '{ print $1 }' >> ansible-inventory
echo '[nodes]' >> ansible-inventory
vagrant status | grep '(libvirt)' | grep node | awk '{ print $1 }' >> ansible-inventory

vagrant ssh-config > ansible-ssh-config

ansible-playbook -i ansible-inventory "$@" playbooks/provision.yml
