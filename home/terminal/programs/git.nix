{
  programs.git = {
    enable = true;
    userName = "Anthony Rodriguez";
    userEmail = "anthony@nezia.dev";
    signing = {
      signByDefault = true;
      key = "EE3BE97C040A86CE";
    };
    extraConfig = {
      push.autoSetupRemote = true;
    };
  };

  programs.lazygit = {
    enable = true;
  };
}
