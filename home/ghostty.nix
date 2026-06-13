{ ... }:

{
  dconf.settings = {
    "org/gnome/desktop/default-applications/terminal" = {
      exec = "ghostty";
      exec-arg = "-e";
    };
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
