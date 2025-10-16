{ config, pkgs, lib, ... }:
{
  services.i2pd = {
    enable = true;
    #cgnat🤷‍♂️
    enableIPv4 = false;
    enableIPv6 = true;
    port = 9111;
    ntcp2.published = true;
    # unstable only
    #ssu2.published = true;
    bandwidth = 2048;
    proto.http.enable = true;
    proto.httpProxy = {
      enable = true;
      outproxy = "http://exit.stormycloud.i2p/,http://purokishi.i2p";
    };
    precomputation.elgamal = false;
  };
  networking.firewall.allowedTCPPorts = [ 9111 ];
  networking.firewall.allowedUDPPorts = [ 9111 ];
}
