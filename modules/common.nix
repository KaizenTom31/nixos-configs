{ config, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Shared user configuration
  users.users.tom = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    initialPassword = "tom";
  };

  # Packages common to all machines
  environment.systemPackages = with pkgs; [
    vim
    htop
  ];
}
