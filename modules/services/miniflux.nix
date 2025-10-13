{ config, pkgs, lib, ... }:

{
  age.secrets.miniflux.file = ../../secrets/miniflux.age;
  age.secrets.cloudflare-dns.file = ../../secrets/cloudflare-dns.age;
  age.secrets.acme-email.file = ../../secrets/acme-email.age;

  services.miniflux = {
    enable = true;
    config = {
      CREATE_ADMIN = 1;
    };
    adminCredentialsFile = config.age.secrets.miniflux.path;
  };

  services.nginx = {
    enable = true;
    
    # Use nginx with QUIC/HTTP3 support
    package = pkgs.nginxQuic;

    recommendedTlsSettings = true;
    recommendedProxySettings = true;
    recommendedOptimisation = true;
    
    virtualHosts = {
      "rss.sh.tomwissing.de" = {
        forceSSL = true;
        quic = true;
        http3 = true;
        useACMEHost = "sh.tomwissing.de";
        locations."/" = {
          proxyPass = "http://127.0.0.1:8080";
          proxyWebsockets = true; # allows live updates if needed
          extraConfig = ''
            add_header Alt-Svc 'h3=":443"; ma=86400';
          '';
        };
      };
    };
  };
  networking.firewall.allowedTCPPorts = [ 80 443 ];
  networking.firewall.allowedUDPPorts = [ 443 ];


  security.acme.acceptTerms = true;
  security.acme.certs."sh.tomwissing.de" = {
    email = "noreply@tomwissing.de";
    domain = "*.sh.tomwissing.de";
    dnsResolver = "8.8.8.8:53";
    dnsProvider = "cloudflare";
    environmentFile = config.age.secrets.cloudflare-dns.path;
  };
  users.users.nginx.extraGroups = ["acme"];
}
