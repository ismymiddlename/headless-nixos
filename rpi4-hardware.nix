{ config, pkgs, ... }:

{
  # Raspberry Pi 4 and Compute Module 4 hardware configuration
  # Both use the BCM2711 SoC and share the same hardware module
  hardware.raspberry-pi."4".apply-overlays-dtmerge.enable = true;
  hardware.deviceTree.enable = true;
  
  # Enable required firmware and tools
  hardware.enableRedistributableFirmware = true;
}
