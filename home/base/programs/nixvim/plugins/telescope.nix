{ ... }:

{
  programs.nixvim.plugins.telescope = {
    enable = true;
    keymaps = {
      "<C-p>" = {
        action = "git_files";
        options = {
          desc = "Telescope Git Files";
        };
      };
      "<leader>fg" = {
        action = "live_grep";
        options = {
          desc = "Live grep";
        };
      };
      "<leader>ff" = {
        action = "find_files";
        options = {
          desc = "Find files";
        };
      };
      "<leader>fp" = {
        action = "projects";
        options = {
          desc = "Find projects";
        };
      };
      "<leader>fb" = {
        action = "buffers";
        options = {
          desc = "Find buffers";
        };
      };
    };
  };
}
