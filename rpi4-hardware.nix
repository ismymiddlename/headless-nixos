{ config, pkgs, ... }:

{
  # Raspberry Pi 4 specific hardware configuration
  hardware.raspberry-pi."4".apply-overlays-dtmerge.enable = true;
  hardware.deviceTree.enable = true;
  
  # Enable required firmware and tools
  hardware.enableRedistributableFirmware = true;
}
