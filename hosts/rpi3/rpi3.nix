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
    device = "/dev/disk/by-uuid/9a6ffedb-a027-4ce4-915f-9e4382183442";
    fsType = "ext4";
    options = [ "noatime" "nodiratime" "commit=60" ];
  };

  # Kernel params
  boot.kernelParams = [ "panic=30" "boot.panic_on_fail" ];


  # Swap
  boot.kernel.sysctl."vm.swappiness" = 10;
  swapDevices = [ { device = "/swapfile"; size = 1024; } ];
  zramSwap = {
    enable = true;
    memoryPercent = 60;
    algorithm = "lzo-rle";
    writebackDevice = "/swapfile";
  };

  # System services
  services.openssh.enable = true;

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

