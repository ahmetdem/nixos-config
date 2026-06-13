{ ... }:

{
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  services.tailscale.enable = true;

  # Encrypted DNS on 127.0.0.1:53 to defeat ISP DNS poisoning. NetworkManager's
  # own DNS is disabled so it can't reinstate the ISP resolvers.
  services.dnscrypt-proxy = {
    enable = true;
    settings = {
      listen_addresses = [ "127.0.0.1:53" ];
      ipv6_servers = true;
      require_dnssec = false;
      require_nolog = true;
      require_nofilter = true;

      sources.public-resolvers = {
        urls = [
          "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
          "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
        ];
        cache_file = "/var/lib/dnscrypt-proxy/public-resolvers.md";
        minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
      };
    };
  };

  networking.networkmanager.dns = "none";
  networking.nameservers = [ "127.0.0.1" ];
}
