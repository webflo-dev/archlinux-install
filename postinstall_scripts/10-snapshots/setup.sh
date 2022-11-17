#!/usr/bin/env bash

# Create base installlation snapshots
sudo snapper ls
sudo snapper -c root create -d " ** base installation ** "
sudo snapper ls
