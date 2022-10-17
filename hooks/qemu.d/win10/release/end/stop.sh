#!/bin/bash
set -x

# Reattach PCIe EPs 
# Replace with appropriate domain/bus/device/function id for IOMMU group where the
# desired passthrough devices are located (Just the EPs are enough)
virsh nodedev-reattach pci_0000_07_00_0
virsh nodedev-reattach pci_0000_07_00_1
virsh nodedev-reattach pci_0000_07_00_2
virsh nodedev-reattach pci_0000_07_00_3

# VM destroyed vfio not needed
modprobe -r vfio-pci

# Rebind efi fb (If used)
#echo efi-framebuffer.0 > /sys/bus/platform/drivers/efi-framebuffer/bind

# Rebind vesa fb (If used)
echo vesa-framebuffer.0 > /sys/bus/platform/drivers/vesa-framebuffer/bind

# Rebind simple fb (If used)
#echo simple-framebuffer.0 > /sys/bus/platform/drivers/simple-framebuffer/bind

# Punch the PCIe (Hack workaround if VM destroyed and still not getting graphics to start)
# Replace with appropriate domain/bus/device/function id for GPU
#echo 1 > /sys/bus/pci/devices/0000:07:00.0/remove
#echo 1 > /sys/bus/pci/rescan

# Load back NVIDIA drivers
modprobe nvidia_drm
modprobe nvidia_modeset
modprobe nvidia_uvm
modprobe nvidia
modprobe i2c_nvidia_gpu

# Rebind VTconsoles
echo 1 > /sys/class/vtconsole/vtcon0/bind
echo 1 > /sys/class/vtconsole/vtcon1/bind

# Start Display manager
systemctl start display-manager
