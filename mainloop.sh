#!/bin/bash

WORK_ROOTDIR='/tmp/workdir'

## Clean old WORK_ROOTDIR
rm -rf $WORK_ROOTDIR

## Create WORK_ROOTDIR directory
mkdir -p $WORK_ROOTDIR

## Download all playbooks
echo "placehooder for downloading playbooks"
git clone https://github.com/marten-t-olsson/bewtstrap.git

## Change directory into betstrap
cd bewtstrap

## Execute ansible-playbook deploy.yml
ansible-playbook deploy.yml
