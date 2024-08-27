{ ... }:

{
  programs.nixvim.plugins.lualine = {
    enable = true;
    extensions = [ "neo-tree" ];
    globalstatus = true;
  };
}
