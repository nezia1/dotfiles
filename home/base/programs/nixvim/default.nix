{ ... }:

{
  imports = [ 
    ./core.nix
    ./keymaps.nix
    ./autocmds.nix

    ./plugins/alpha.nix
    ./plugins/lsp.nix 
    ./plugins/lualine.nix
    ./plugins/neo-tree.nix
    ./plugins/which-key.nix
    ./plugins/project-nvim.nix
    ./plugins/misc.nix
  ];

}
