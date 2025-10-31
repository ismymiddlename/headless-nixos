{ config, pkgs, ... }:

{
  # Raspberry Pi 4 and Compute Module 4 hardware configuration
  # Both use the BCM2711 SoC and share the same hardware module
  hardware.raspberry-pi."4".apply-overlays-dtmerge.enable = true;
  hardware.deviceTree.enable = true;
  
  # Enable required firmware and tools
  hardware.enableRedistributableFirmware = true;
  
  # Fix for sd-aarch64 format trying to include sun4i-drm module
  # which doesn't exist in the RPi4 kernel (it's for Allwinner SoCs)
  boot.initrd.includeDefaultModules = false;
  
  # Explicitly specify required kernel modules for RPi4
  boot.initrd.availableKernelModules = [
    # Storage
    "mmc_block"
    "usb_storage"
    
    # USB/Input
    "usbhid"
    
    # Filesystems
    "ext4"
    "vfat"
  ];
}
