#!/usr/bin/env bash

if ! command -v snapper &> /dev/null
then
    echo "snapper could not be found"
    exit
fi


# Create base installlation snapshots
sudo snapper ls
sudo snapper -c root create -d " ** base installation ** "
sudo snapper ls
