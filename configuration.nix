{ config, pkgs, ... }:

{
  # NixOS 25.05 stable
  system.stateVersion = "25.05";

  # Enable SSH service
  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      PermitRootLogin = "yes";
      PasswordAuthentication = true;
    };
  };

  # Network configuration
  networking.useDHCP = true;

  # Default user configuration
  users.users.nixos = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    password = "changeit";
    openssh.authorizedKeys.keys = [ ];
  };

  # Enable sudo for wheel group
  security.sudo.wheelNeedsPassword = false;

  # Minimal system packages
  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    git
    openssh
  ];

  # Time zone
  time.timeZone = "UTC";

  # Locale
  i18n.defaultLocale = "en_US.UTF-8";
}
