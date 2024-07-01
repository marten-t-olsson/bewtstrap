#!/bin/bash

WORK_ROOTDIR="/tmp/workdir"
CONFIG_ROOTDIR="/etc/mainloop"
CONFIG_FILE="${CONFIG_ROOTDIR}/playbooks"

## Clean old WORK_ROOTDIR
rm -rf $WORK_ROOTDIR

## Create WORK_ROOTDIR directory
mkdir -p $WORK_ROOTDIR

## Change path to WORK_ROOTDIR directory
cd $WORK_ROOTDIR

## Placeholder for fetching the playbook config for this device
echo "Placeholder for fetching the playbook config for this device"

## Write playbook config to local file (static for now)
sudo tee <<EOF  $CONFIG_FILE
declare -A playbooks
playbooks[https://github.com/marten-t-olsson/bewtstrap.git]="1.1"
EOF

## Download all playbooks
source $CONFIG_FILE

for REPO in ${!playbooks[@]};
do   
	TAG=${playbooks[$REPO]}
	git clone --depth 1 --branch $TAG $REPO
done

#git clone https://github.com/marten-t-olsson/bewtstrap.git

## Change directory into betstrap
cd bewtstrap

## Execute ansible-playbook deploy.yml
ansible-playbook deploy.yml
