#!/usr/bin/env bash

SOURCEDIR=$(dirname ${BASH_SOURCE[0]})


cd /

# Manage snapshots subvolume
sudo umount /.snapshots
sudo rm -rf /.snapshots
sudo snapper -c root create-config /
sudo btrfs subvol del /.snapshots/
sudo mkdir /.snapshots
sudo mount -a
sudo chown -R :wheel /.snapshots/

# Change default subvolume
sudo btrfs subvol lis /
sudo btrfs subvol get-def /
sudo btrfs subvol set-def 256 /
sudo btrfs subvol get-def /


# Update snapper configuration
sudo install -d -m 755 /etc/snapper/configs/
sudo install -Dm 644 ${SOURCEDIR}/snapper-root-config /etc/snapper/configs/root


# Enable bootable btrfs snapshots
sudo systemctl enable --now grub-btrfs.path
sudo systemctl status grub-btrfs.path
sudo grub-mkconfig -o /boot/grub/grub.cfg
