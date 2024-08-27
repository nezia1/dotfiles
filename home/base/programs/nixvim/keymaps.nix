{ ... }:

{
  programs.nixvim.keymaps = [
    {
      action = "<cmd>Telescope find_files<CR>";
      key = "<leader>ff";
      options = {
        desc = "Find files";
      };
    }
    {
      action = "<cmd>Telescope projects<CR>";
      key = "<leader>fp";
      options = {
        desc = "Find projects";
      };
    }
    {
      action = "<cmd>Neotree toggle<CR>";
      key = "<leader>ft";
      options = {
        desc = "Toggle neo-tree";
      };
    }      
    {
      action = ''
          <cmd>lua vim.lsp.buf.code_action({ apply = true })<CR>
      '';
      key = "<leader>lc";
      options = {
        desc = "Apply code actions";
      };
    }
    {
      action = ''
          <cmd>lua vim.lsp.buf.format()<CR>
      '';
      key = "<leader>lf";
      options = {
        desc = "Format buffer";
      };
    }
  ];
}
