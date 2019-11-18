#!/bin/bash

# verify script is being run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

# backup root directory
date=`date +"%m%d%Y-%H%M%S"`
cd /
tar -cvpzf backup-${date}.tar.gz \
--exclude=/backup-*-*.tar.gz \
--exclude=/backup-*-*.tar.gz.cpt \
--exclude=/proc \
--exclude=/tmp \
--exclude=/mnt \
--exclude=/dev \
--exclude=/sys \
--exclude=/run \
--exclude=/media \
--exclude=/var/log \
--exclude=/var/cache/apt/archives \
--exclude=/usr/src/linux-headers* \
--exclude=/home/*/.gvfs \
--exclude=/home/*/.cache \
--exclude=/home/*/.local/share/Trash \
/

# encrypt backup
ccrypt backup-${date}.tar.gz
