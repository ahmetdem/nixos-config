{ ... }:

{
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
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
}
