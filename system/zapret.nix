{ config, pkgs, ... }:

let
  systemctl = "${config.systemd.package}/bin/systemctl";
  conntrack = "${pkgs.conntrack-tools}/bin/conntrack";
  nmcli = "${pkgs.networkmanager}/bin/nmcli";
  tee = "${pkgs.coreutils}/bin/tee";
  awk = "${pkgs.gawk}/bin/awk";
  notify = "${pkgs.libnotify}/bin/notify-send";

  # Quick DPI bypass on/off (DNS untouched).
  zapret-toggle = pkgs.writeShellScriptBin "zapret-toggle" ''
    set -uo pipefail
    if ${systemctl} is-active --quiet zapret; then
      sudo ${systemctl} stop zapret
      msg="OFF — traffic untouched"
      icon=network-offline-symbolic
    else
      sudo ${systemctl} start zapret
      msg="ON — DPI bypass active"
      icon=network-vpn-symbolic
    fi
    echo "zapret: $msg"
    ${notify} -i "$icon" "zapret" "$msg" 2>/dev/null || true
  '';

  # Captive-portal / public-wifi mode (also the panic button): stops the stack
  # and uses the network's own plain DNS so the login page loads.
  net-portal = pkgs.writeShellScriptBin "net-portal" ''
    set -uo pipefail
    echo "Public-wifi mode: tearing down zapret/dnscrypt/tailscale..."
    sudo ${systemctl} stop zapret 2>/dev/null || true
    sudo ${systemctl} stop dnscrypt-proxy 2>/dev/null || true
    sudo ${systemctl} stop tailscaled 2>/dev/null || true

    iface=$(${nmcli} -t -f DEVICE,STATE dev 2>/dev/null | ${awk} -F: '$2=="connected"{print $1; exit}')
    dns=$(${nmcli} -t -g IP4.DNS dev show "$iface" 2>/dev/null | ${awk} 'NR==1{print}')
    [ -z "$dns" ] && dns=1.1.1.1

    printf 'nameserver %s\n' "$dns" | sudo ${tee} /etc/resolv.conf >/dev/null
    sudo ${conntrack} -F 2>/dev/null || true
    echo "Done: open mode, DNS=$dns. Log into the portal, then run: net-secure"
    ${notify} -i network-wireless-symbolic "network" "Public-wifi mode (DNS=$dns) — log in, then net-secure" 2>/dev/null || true
  '';

  # Restore the secure stack: encrypted DNS, DPI bypass, and tailscale.
  net-secure = pkgs.writeShellScriptBin "net-secure" ''
    set -uo pipefail
    echo "Restoring secure mode: dnscrypt + zapret + tailscale..."
    sudo ${systemctl} start dnscrypt-proxy
    printf 'nameserver 127.0.0.1\n' | sudo ${tee} /etc/resolv.conf >/dev/null
    sudo ${systemctl} start tailscaled
    sudo ${systemctl} start zapret
    echo "Done: encrypted DNS + DPI bypass active."
    ${notify} -i network-vpn-symbolic "network" "Secure mode (dnscrypt + zapret)" 2>/dev/null || true
  '';
in
{
  services.zapret = {
    enable = true;

    configureFirewall = true;
    httpSupport = false;

    udpSupport = false;

    params = [
      "--filter-tcp=443"
      "--dpi-desync=multisplit"
      "--dpi-desync-split-pos=2"
    ];
  };

  environment.systemPackages = [
    zapret-toggle
    net-portal
    net-secure
  ];

  # Passwordless, hotkey-bindable switch commands, scoped to exactly these ops.
  security.sudo.extraRules = [
    {
      users = [ "ahmetdem" ];
      commands = [
        {
          command = "${systemctl} start zapret";
          options = [ "NOPASSWD" ];
        }
        {
          command = "${systemctl} stop zapret";
          options = [ "NOPASSWD" ];
        }
        {
          command = "${systemctl} restart zapret";
          options = [ "NOPASSWD" ];
        }
        {
          command = "${systemctl} start dnscrypt-proxy";
          options = [ "NOPASSWD" ];
        }
        {
          command = "${systemctl} stop dnscrypt-proxy";
          options = [ "NOPASSWD" ];
        }
        {
          command = "${systemctl} start tailscaled";
          options = [ "NOPASSWD" ];
        }
        {
          command = "${systemctl} stop tailscaled";
          options = [ "NOPASSWD" ];
        }
        {
          command = "${systemctl} restart NetworkManager";
          options = [ "NOPASSWD" ];
        }
        {
          command = "${conntrack} -F";
          options = [ "NOPASSWD" ];
        }
        {
          command = "${tee} /etc/resolv.conf";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];
}
