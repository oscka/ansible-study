#!/bin/bash

TAGS=$1

# export ANSIBLE_HOST_KEY_CHECKING=False

ansible-playbook -i hosts-vm  playbook-step6.yml   -t "$TAGS" 
