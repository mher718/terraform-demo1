#!/bin/bash

set -e

echo "Cleaning up netplan"
sudo mv /etc/netplan/99-netcfg-vmware.yaml /etc/netplan/01-netcfg.yaml
sudo rm /etc/netplan/01-netcfg.yaml.BeforeVMwareCustomization
echo "Done"

echo "Fixing /etc/resolv.conf"
sudo rm /etc/resolv.conf
sudo ln -s /run/systemd/resolve/resolv.conf /etc/resolv.conf
echo "Done fixing resolv.conf"


echo "Updating packages"
sudo apt update -y > /dev/null 2>&1
sudo DEBIAN_FRONTEND=noninteractive apt upgrade -y  > /dev/null 2>&1
sudo DEBIAN_FRONTEND=noninteractive apt autoremove -y > /dev/null 2>&1

#echo "Extending LVM"
#sudo chmod +x resize.sh
#sudo ./resize.sh /dev/sda 3 apply
#sudo growpart /dev/sda 3
#sudo parted -s -a opt /dev/sda "resizepart 3 100%"
#sudo pvresize /dev/sda3
#sudo lvextend -r /dev/mapper/ubuntu--vg-root -l '+100%FREE'
#sudo lvremove vg0 lv-dummy -y > /dev/null 2>&1
#echo "Done resizing disk!"

#echo "Add additional logical volumes"
#sudo lvcreate -L 50G -n lv-docker vg0
#sudo mkfs.ext4 /dev/mapper/vg0-lv--docker
#sudo mkdir -p /var/lib/docker
#echo "/dev/mapper/vg0-lv--docker /var/lib/docker ext4    defaults        0       2" | sudo tee -a /etc/fstab
#echo "Done adding new lvm."

echo "Disabling swap"
sudo swapoff -a
sudo sed -i '/swap/d' /etc/fstab
echo "Done disabling swap!"


echo "Cleaning up home directory"
sudo rm -rf /home/administrator/*
echo "Done"

#sudo reboot
