{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 0; 

  # Load the AMD iGPU driver early (PRIME render offload pairs it with Nvidia)
  boot.initrd.kernelModules = [ "amdgpu" ];

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Istanbul";
  services.flatpak.enable = true;

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "tr_TR.UTF-8";
    LC_IDENTIFICATION = "tr_TR.UTF-8";
    LC_MEASUREMENT = "tr_TR.UTF-8";
    LC_MONETARY = "tr_TR.UTF-8";
    LC_NAME = "tr_TR.UTF-8";
    LC_NUMERIC = "tr_TR.UTF-8";
    LC_PAPER = "tr_TR.UTF-8";
    LC_TELEPHONE = "tr_TR.UTF-8";
    LC_TIME = "tr_TR.UTF-8";
  };

  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  services.xserver.xkb = {
    layout = "tr";
    variant = "";
  };
  console.keyMap = "trq";

  # Use the nvidia driver; amdgpu is loaded automatically for the iGPU
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = true;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    prime = {
      offload.enable = true;
      offload.enableOffloadCmd = true;

      # From lspci: AMD iGPU and Nvidia dGPU bus IDs
      amdgpuBusId = "PCI:5:0:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };

  boot.plymouth.enable = true;
  boot.kernelParams = [
    "quiet"
    "splash"
  ];

  services.printing.enable = true;

  security.rtkit.enable = true;
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.tailscale.enable = true;

  users.users.ahmetdem = {
    isNormalUser = true;
    description = "Ahmet Yusuf Demir";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  programs.nix-ld.enable = true; # lets unpatched dynamic binaries run

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    neovim
    git
    gh
    ghostty
    appimage-run
    gcc
    gnumake
    zapret
    gnome-tweaks
  ];

  environment.gnome.excludePackages = with pkgs; [
    gnome-maps
    gnome-music
    gnome-tour
    gnome-weather
    gnome-contacts
    epiphany
    totem
    cheese
    gnome-connections
    gnome-console
    geary
    yelp
    gnome-user-docs
    xterm
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.zed-mono
  ];

  # Tell NetworkManager not to override DNS
  networking.nameservers = [ "127.0.0.1" ];
  networking.networkmanager.dns = "none";

  services.dnscrypt-proxy = {
    enable = true;
    settings = {
      listen_addresses = [ "127.0.0.1:53" ];
      bootstrap_resolvers = [ "192.168.1.1:53" ];
      ignore_system_dns = true;
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

  systemd.services.dnscrypt-proxy.serviceConfig.StateDirectory = "dnscrypt-proxy";

  services.zapret = {
    enable = true;
    configureFirewall = true;
    httpSupport = true;
    params = [
      "--dpi-desync=multisplit"
      "--dpi-desync-split-pos=2"
    ];
    udpSupport = true;
    udpPorts = [ "443" ];
  };

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    auto-optimise-store = true;
  };

  environment.sessionVariables = {
    XDG_DATA_DIRS = [
      "/var/lib/flatpak/exports/share"
      "$HOME/.local/share/flatpak/exports/share"
    ];
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  system.stateVersion = "25.11";
}
