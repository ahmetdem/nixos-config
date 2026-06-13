{ pkgs, ... }:

{
  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  services.printing.enable = true;
  services.flatpak.enable = true;

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

  environment.sessionVariables = {
    XDG_DATA_DIRS = [
      "/var/lib/flatpak/exports/share"
      "$HOME/.local/share/flatpak/exports/share"
    ];
  };
}
