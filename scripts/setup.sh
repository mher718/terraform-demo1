#!/bin/bash

set -e

echo "Cleaning up netplan"
sudo mv /etc/netplan/99-netcfg-vmware.yaml /etc/netplan/01-netcfg.yaml
sudo rm /etc/netplan/00*
#sudo rm /etc/netplan/
echo "Done"

echo "Fixing /etc/resolv.conf"
sudo rm /etc/resolv.conf
sudo ln -s /run/systemd/resolve/resolv.conf /etc/resolv.conf
echo "Done fixing resolv.conf"

echo "Disabling swap"
sudo swapoff -a
sudo sed -i '/swap/d' /etc/fstab
echo "Done disabling swap!"

sudo mount -a
#sudo reboot
exit