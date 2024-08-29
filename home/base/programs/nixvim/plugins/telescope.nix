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
          desc = "Files";
        };
      };
      "<leader>fp" = {
        action = "projects";
        options = {
          desc = "Projects";
        };
      };
      "<leader>fb" = {
        action = "buffers";
        options = {
          desc = "Buffers";
        };
      };
    };
  };
}
