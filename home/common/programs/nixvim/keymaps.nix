{ ... }:

{
  programs.nixvim.keymaps = [
    {
      action = "<cmd>Neotree toggle<CR>";
      key = "<leader>t";
      options = {
        desc = "Neotree";
      };
    }      
  ];
}
