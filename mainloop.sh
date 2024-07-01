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
playbooks[https://github.com/marten-t-olsson/bewtstrap.git]="1.2"
playbooks[https://github.com/marten-t-olsson/deploy-docker.git]="1.1"
EOF

## Download all playbooks
source $CONFIG_FILE

for REPO in ${!playbooks[@]};
do   
	TAG=${playbooks[$REPO]}
	git clone --depth 1 --branch $TAG $REPO
	## Convert repo URL into shortname
	SHORTNAME=$(echo $REPO | awk -F/ '{ print $NF }' | awk -F. '{ print $1 }')
	## Change directory into clone
	cd ${WORK_ROOTDIR}/$SHORTNAME
	## Execute ansible-playbook deploy.yml
	ansible-playbook main.yml
done
