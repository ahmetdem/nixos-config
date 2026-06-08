{
  pkgs,
  antigravity-nix,
  system,
  ...
}:

{
  home.username = "ahmetdem";
  home.homeDirectory = "/home/ahmetdem";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  programs.neovim = {
    enable = true;
    withRuby = false;
    withPython3 = false;
  };

  xdg.configFile."nvim" = {
    source = ./nvim;
    recursive = true;
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "github.com" = {
        identityFile = "~/.ssh/id_ed25519";
        addKeysToAgent = "yes";
      };
    };
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };

  dconf.settings = {
    "org/gnome/desktop/default-applications/terminal" = {
      exec = "ghostty";
      exec-arg = "-e";
    };
  };

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
    mangohud
    goverlay
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

  programs.git = {
    enable = true;
    settings = {
      user.name = "Ahmet Yusuf Demir";
      user.email = "ahmetyusufdmr88@gmail.com";
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
    };
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      ls = "eza --icons --group-directories-first";
      ll = "eza -l --icons --git";
      c = "clear";
      conf = "svim /etc/nixos/configuration.nix";
      home = "svim /etc/nixos/home.nix";
      flake = "svim /etc/nixos/flake.nix";
      rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#nixos";
      svim = "sudo -E nvim";
      update = ''sudo sh -c "cd /etc/nixos && nix flake update && nixos-rebuild switch --flake /etc/nixos#nixos"'';
      garbage = "sudo nix-collect-garbage -d";
    };
    initExtra = ''
      if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
        PATH="$HOME/.local/bin:$HOME/bin:$PATH"
      fi
      export PATH=$PATH:$(go env GOPATH)/bin
      export PATH="$HOME/.local/bin:$PATH"
      export PATH=$PATH:$HOME/tools/odin

      HISTSIZE=-1
      export TERMINAL=ghostty
      export EDITOR=nvim
      export VISUAL=nvim

      export FZF_DEFAULT_OPTS="
        --height 20%
        --layout=reverse
        --border
        --info=inline
        --color='gutter:-1,bg+:-1'
      "

      eval "$(fzf --bash)"
      eval "$(zoxide init bash)"

      bind 'TAB:menu-complete'
      bind '"\e[Z":menu-complete-backward'  # shift+tab to go back
      bind 'set completion-ignore-case on'

      wifi-login() {
        sudo systemctl stop dnscrypt-proxy zapret || return 1
        local dns
        dns=$(nmcli -t -f IP4.DNS dev show 2>/dev/null | cut -d: -f2 | grep -v '^127\.' | head -1)
        [[ -z "$dns" ]] && dns=$(ip route show default 2>/dev/null | awk '{print $3; exit}')
        [[ -z "$dns" ]] && dns="1.1.1.1"
        printf 'nameserver %s\n' "$dns" | sudo tee /run/resolv-login.conf >/dev/null
        sudo mount --bind /run/resolv-login.conf "$(readlink -f /etc/resolv.conf)"
        echo "Login mode active — DNS: $dns"
      }

      wifi-secure() {
        sudo umount "$(readlink -f /etc/resolv.conf)" 2>/dev/null || true
        sudo rm -f /run/resolv-login.conf
        sudo systemctl start dnscrypt-proxy zapret
        echo "Secure mode restored"
      }
    '';
    bashrcExtra = ''
      PS1="''${VIRTUAL_ENV_PROMPT:+(''${VIRTUAL_ENV_PROMPT}) }\[\e[1;32m\]\w\[\e[0m\]$ ";
      unset PROMPT_COMMAND
      export PROMPT_DIRTRIM=2
    '';
    historyControl = [
      "ignoredups"
      "erasedups"
    ];
  };

  programs.ghostty = {
    enable = true;
    settings = {
      font-family = "ZedMono Nerd Font";
      font-size = 16.8;

      background = "#1e3a3f";
      foreground = "#ffffff";
      cursor-color = "#ffffff";
      selection-background = "#3c4048";
      selection-foreground = "#ffffff";

      palette = [
        "0=#152629"
        "1=#ff6e5e"
        "2=#5eff6c"
        "3=#f1ff5e"
        "4=#5ea1ff"
        "5=#bd5eff"
        "6=#5ef1ff"
        "7=#ffffff"
        "8=#3c4048"
        "9=#ff6e5e"
        "10=#5eff6c"
        "11=#f1ff5e"
        "12=#5ea1ff"
        "13=#bd5eff"
        "14=#5ef1ff"
        "15=#ffffff"
      ];

      gtk-tabs-location = "hidden";
      window-decoration = true;
      gtk-titlebar = false;
      maximize = true;
      window-padding-x = 5;
      window-padding-y = 5;
      window-width = 110;
      window-height = 30;
      resize-overlay = "never";

      keybind = [
        "ctrl+backspace=text:\\x1b\\x7f"
        "ctrl+delete=text:\\x1b[3;5~"
        "ctrl+left=text:\\x1bb"
        "ctrl+right=text:\\x1bf"
        "alt+shift+l=new_split:right"
        "alt+shift+j=new_split:down"
        "alt+shift+h=new_split:left"
        "alt+shift+k=new_split:up"
        "alt+l=goto_split:right"
        "alt+j=goto_split:bottom"
        "alt+h=goto_split:left"
        "alt+k=goto_split:top"
        "alt+1=goto_tab:1"
        "alt+2=goto_tab:2"
        "alt+3=goto_tab:3"
        "alt+4=goto_tab:4"
        "alt+5=goto_tab:5"
        "alt+6=goto_tab:6"
        "alt+7=goto_tab:7"
        "alt+8=goto_tab:8"
        "alt+digit_1=goto_tab:1"
        "alt+digit_2=goto_tab:2"
        "alt+digit_3=goto_tab:3"
        "alt+digit_4=goto_tab:4"
        "alt+digit_5=goto_tab:5"
        "alt+digit_6=goto_tab:6"
        "alt+digit_7=goto_tab:7"
        "alt+digit_8=goto_tab:8"
      ];
    };
  };
}
