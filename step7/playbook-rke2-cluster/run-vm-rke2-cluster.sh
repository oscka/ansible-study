#!/bin/bash

TAGS=$1


ansible-playbook -i hosts-vm playbook-rke2-cluster.yml   -t "$TAGS"  -e "@external/external-vars.yml"
