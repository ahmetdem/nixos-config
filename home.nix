{ ... }:

{
  imports = [
    ./home/neovim.nix
    ./home/shell.nix
    ./home/ghostty.nix
    ./home/git.nix
    ./home/ssh.nix
    ./home/packages.nix
    ./home/mangohud.nix
  ];

  home.username = "ahmetdem";
  home.homeDirectory = "/home/ahmetdem";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;
}
