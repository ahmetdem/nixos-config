{
  pkgs,
  antigravity-nix,
  system,
  ...
}:

{
  home.packages = with pkgs; [
    wl-clipboard
    eza
    zoxide
    fzf
    go
    helium
    prismlauncher
    claude-code
    gparted
    antigravity-nix.packages.${system}.google-antigravity
    python3
    onlyoffice-desktopeditors
    yazi
    texlive.combined.scheme-medium
    fragments
    unityhub
    gapless
    obs-studio
    jetbrains.idea-oss
    vesktop
    zulu21

    # GNOME Extensions
    gnomeExtensions.blur-my-shell
    gnomeExtensions.custom-hot-corners-extended
    gnomeExtensions.just-perfection
    gnomeExtensions.rounded-window-corners-reborn
    gnomeExtensions.user-themes
    gnomeExtensions.vitals
    gnomeExtensions.middle-click-to-close-in-overview
    gnomeExtensions.caffeine

    # LSP servers
    clang-tools
    lua-language-server
    pyright
    typescript-language-server
    bash-language-server
    zls
    marksman
    nixfmt-rfc-style
    nixd

    # Formatters
    stylua
    black
    isort
    shfmt
    gofumpt
  ];
}
