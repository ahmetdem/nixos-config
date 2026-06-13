{ ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user.name = "Ahmet Yusuf Demir";
      user.email = "ahmetyusufdmr88@gmail.com";
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
    };
  };
}
