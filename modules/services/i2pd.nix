{ config, pkgs, lib, ... }:
{
  services.i2pd = {
    enable = true;
    #cgnat🤷‍♂️
    enableIPv4 = false;
    enableIPv6 = true;
    port = 9111;
    bandwidth = 2048;
    proto.http.enable = true;
    proto.httpProxy.enable = true;
    precomputation.elgamal = false;
  };
}
