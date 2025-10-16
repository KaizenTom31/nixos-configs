let
  rpi3 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG6WWrTCNaWrfLxAu38V61dotVK7VAQMrlCSgYdoNLpq";
  wsl = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICCYThDgNq+o/1qCWm1yXL7uJ/AACM1bNBXNZBxeCkX9";
  systems = [ rpi3 wsl ];
in
{
  "miniflux.age".publicKeys = systems;
  "cloudflare-dns.age".publicKeys = systems;
  "acme-email.age".publicKeys = systems;
  "rpi3-wireguard-pr.age".publicKeys = systems;
  "rpi3-wireguard-sh.age".publicKeys = systems;
}