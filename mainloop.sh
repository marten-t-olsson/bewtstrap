#!/bin/bash

WORK_ROOTDIR='/tmp/workdir'

## Clean old WORK_ROOTDIR
rm -rf $WORK_ROOTDIR

## Create and change directory to WORK_ROOTDIR
mkdir -p $WORK_ROOTDIR
cd $WORK_ROOTDIR
pwd

## Download all playbooks
echo "placehooder for downloading playbooks"

## Execute ansible-playbook deploy.yml
ansible-playbook deploy.yml
