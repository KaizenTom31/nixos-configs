{ config, pkgs, lib, ... }:

{
    services.adguardhome = {
      enable = true;
  };
  networking.firewall.allowedUDPPorts = [ 53 ];
  networking.firewall.allowedTCPPorts = [ 53 ];
}
