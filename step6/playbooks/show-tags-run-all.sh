#!/bin/bash

TAGS=$1

if [ -z $TAGS ]; then
    ansible-playbook  playbook-step6.yml   --list-tags --list-tasks
else
    ansible-playbook  playbook-step6.yml  --list-tasks | grep $TAGS
fi
