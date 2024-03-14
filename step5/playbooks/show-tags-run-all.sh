#!/bin/bash

TAGS=$1

if [ -z $TAGS ]; then
    ansible-playbook  playbook-step4.yml   --list-tags --list-tasks
else
    ansible-playbook  playbook-step4.yml  --list-tasks | grep $TAGS
fi