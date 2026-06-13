{ pkgs, ... }:

{
  # Install neovim only. The Lua config is its own git repo living directly at
  # ~/.config/nvim, edited live and NOT managed by nix. We deliberately do NOT
  # use programs.neovim, because that module generates its own ~/.config/nvim/
  # init.lua and would clobber the live config.
  home.packages = [ pkgs.neovim ];
}
