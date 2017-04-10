#!/bin/bash

set -eu

bash inventory.sh

# move to playbooks/configure.yml and remove the symlink when
# https://github.com/ansible/ansible/issues/17869 is fixed
ansible-playbook -i ansible-inventory "$@" configure.yml
