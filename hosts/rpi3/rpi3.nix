{ config, pkgs, inputs, ... }:

{
  system.stateVersion = "25.05";
  imports = [
    #./hardware-configuration.nix
    ./wireguard.nix
    "${inputs.nixpkgs}/nixos/modules/profiles/minimal.nix"
  ];

  hardware.enableRedistributableFirmware = true;
  networking.tempAddresses = "enabled";

  # Hostname
  networking.hostName = "nixos_rpi3";

  # Networking
  networking.networkmanager.enable = true;

  # Timezone
  time.timeZone = "Europe/Berlin";

  # Bootloader
  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;

  # File system options
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/44444444-4444-4444-8888-888888888888";
    fsType = "ext4";
    options = [ "noatime" "nodiratime" "commit=60" ];
  };

  # Swap
  swapDevices = [ { device = "/swapfile"; size = 512; } ];

  # Kernel params
  boot.kernelParams = [ "panic=1" "boot.panic_on_fail" ];

  # System services
  services.openssh.enable = true;

  zramSwap.enable = true;
  services.fstrim.enable = true;

  # Journald in RAM
  services.journald = {
      storage = "volatile";
      extraConfig = "RuntimeMaxUse=5M";
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
}

