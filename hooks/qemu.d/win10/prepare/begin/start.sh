#!/bin/bash
set -x

# Stop display-manager
systemctl stop display-manager

# Unbind VTConsoles
echo 0 > /sys/class/vtconsole/vtcon0/bind
echo 0 > /sys/class/vtconsole/vtcon1/bind

# Unbind efi fb
#echo efi-framebuffer.0 > /sys/bus/platform/drivers/efi-framebuffer/unbind

# Unbind vesa fb
echo vesa-framebuffer.0 > /sys/bus/platform/drivers/vesa-framebuffer/unbind

#unbind simple fb
#echo simple-framebuffer.0 > /sys/bus/platform/drivers/simple-framebuffer/unbind

# Unload NVIDIA modules
modprobe -r nvidia_drm nvidia_modeset drm nvidia_uvm nvidia i2c_nvidia_gpu 

# Detach PCIe PCIe EPs from host
virsh nodedev-detach pci_0000_07_00_0
virsh nodedev-detach pci_0000_07_00_1
virsh nodedev-detach pci_0000_07_00_2
virsh nodedev-detach pci_0000_07_00_3

# Load vfio module to vanage IOMMU groups
modprobe vfio_pci
