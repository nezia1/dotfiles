{ ... }:

{
  # fix direnv integration with fish
  environment.pathsToLink = [ "/share/fish" ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
}
