{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./system/boot.nix
    ./system/graphics.nix
    ./system/desktop.nix
    ./system/networking.nix
    ./system/audio.nix
    ./system/locale.nix
    ./system/packages.nix
    ./system/nix.nix
    ./system/zapret.nix
  ];

  users.users.ahmetdem = {
    isNormalUser = true;
    description = "Ahmet Yusuf Demir";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  system.stateVersion = "25.11";
}
