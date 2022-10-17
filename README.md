Debugging 
* Check BIOS/EFI settings (Virtualizatios/IOMMU)
* Check journal/dmesg Pass/HW errors, Virt if enabled,...
* Check systemctl libvirtd
* Check /var/log/libvirt/qemu/
* Check if anyone else is using memory /proc/iomem
* Setup sshd, easier debugging once display-manager is killed
* Check kernel params from host if experiencing performance degradation

For Win11:

* Emulate/Passthrough TPM
* UEFI with secboot is required for win11 to work
