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
      action = "<cmd>Telescope buffers<CR>";
      key = "<leader>fb";
      options = {
        desc = "Find buffers";
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
    {
      action = ''
        <cmd>Telescope lsp_definitions<CR>
      '';
      key = "gd";
      options = {
        desc = "Go to definitions";
      };
    }
    {
      action = ''
        <cmd>Telescope lsp_references<CR>
      '';
      key = "gr";
      options = {
        desc = "Go to references";
      };
    }
  ];
}
