#!/bin/bash

TAGS=$1

if [ -z $TAGS ]; then
    ansible-playbook  playbook-rke2-cluster.yml    --list-tags --list-tasks 
else
    ansible-playbook  playbook-rke2-cluster.yml    --list-tasks | grep $TAGS
fi



