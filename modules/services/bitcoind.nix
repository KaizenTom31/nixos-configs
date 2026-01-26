{ config, pkgs, lib, ... }:

{
  services.bitcoind.main = {
    enable = true;

    prune = 5500;
    dbCache = 300;

    extraConfig = ''
      server=1
      txindex=0
      maxconnections=20
      blocksonly=1
    '';
  };
}
