#!/bin/bash

WORK_ROOTDIR='/tmp/workdir'

## Clean old WORK_ROOTDIR
rm -rf $WORK_ROOTDIR

## Create WORK_ROOTDIR directory
mkdir -p $WORK_ROOTDIR

## Change path to WORK_ROOTDIR directory
cd $WORK_ROOTDIR

## Placeholder for fetching the playbook config for this device
echo "Placeholder for fetching the playbook config for this device"

## Placeholder for writing playbook config to local file
echo "Placeholder for writing playbook config to local file"

## Download all playbooks
git clone https://github.com/marten-t-olsson/bewtstrap.git

## Change directory into betstrap
cd bewtstrap

## Execute ansible-playbook deploy.yml
ansible-playbook deploy.yml
