{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    neovim
    git
    gh
    ghostty
    appimage-run
    gcc
    gnumake
    gnome-tweaks
  ];

  programs.steam.enable = true;
  programs.gamemode.enable = true;

  programs.nix-ld.enable = true; # lets unpatched dynamic binaries run
  programs.nix-ld.libraries = with pkgs; [
    glfw3-minecraft
    openal
    alsa-lib
    libjack2
    libpulseaudio
    pipewire
    libGL
    libglvnd
    mesa
    wayland
    libxkbcommon
    udev
    vulkan-loader
    flite
    fontconfig
    freetype
    libX11
    libXcursor
    libXext
    libXi
    libXrandr
    libXrender
    libXtst
    libXxf86vm
    xprop
    zenity
  ];
}
