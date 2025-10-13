{ config, pkgs, lib, ... }:

{
    services.adguardhome = {
      enable = true;
  };
  
  users.users.adguardhome = {
    isSystemUser = true;
    extraGroups = ["acme"];
    group = "adguardhome";
  };
  users.groups.adguardhome = {};

  networking.firewall.allowedUDPPorts = [ 53 853 ];
  networking.firewall.allowedTCPPorts = [ 53 853 ];

  services.nginx = {
    virtualHosts = {
      "dns.sh.tomwissing.de" = {
        forceSSL = true;
        quic = true;
        http3 = true;
        useACMEHost = "sh.tomwissing.de";
        locations."/" = {
          proxyPass = "http://127.0.0.1:8000";
          proxyWebsockets = true; # allows live updates if needed
        };
      };
    };
  };
}
