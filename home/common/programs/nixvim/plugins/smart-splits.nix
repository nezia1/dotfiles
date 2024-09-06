{
  programs.nixvim = {
    plugins.smart-splits = {
      enable = true;
      settings = {
        ignored_events = [
          "BufEnter"
          "WinEnter"
        ];
        resize_mode = {
          quit_key = "<ESC>";
          resize_keys = [
            "h"
            "j"
            "k"
            "l"
          ];
          silent = true;
        };
      };
    };

    keymaps = [
      {
        action = "<cmd>lua require('smart-splits').resize_left()<CR>";
        key = "<A-h>";
        options = {
          desc = "Resize split to the left";
        };
      }
      {
        action = "<cmd>lua require('smart-splits').resize_down()<CR>";
        key = "<A-j>";
        options = {
          desc = "Resize split downwards";
        };
      }
      {
        action = "<cmd>lua require('smart-splits').resize_up()<CR>";
        key = "<A-k>";
        options = {
          desc = "Resize split upwards";
        };
      }
      {
        action = "<cmd>lua require('smart-splits').resize_right()<CR>";
        key = "<A-l>";
        options = {
          desc = "Resize split to the right";
        };
      }
      {
        action = "<cmd>lua require('smart-splits').move_cursor_left()<CR>";
        key = "<C-h>";
        options = {
          desc = "Move cursor to the left split";
        };
      }
      {
        action = "<cmd>lua require('smart-splits').move_cursor_down()<CR>";
        key = "<C-j>";
        options = {
          desc = "Move cursor to the downward split";
        };
      }
      {
        action = "<cmd>lua require('smart-splits').move_cursor_up()<CR>";
        key = "<C-k>";
        options = {
          desc = "Move cursor to the upward split";
        };
      }
      {
        action = "<cmd>lua require('smart-splits').move_cursor_right()<CR>";
        key = "<C-l>";
        options = {
          desc = "Move cursor to the right split";
        };
      }
      {
        action = "<cmd>lua require('smart-splits').move_cursor_previous()<CR>";
        key = "<C-\\>";
        options = {
          desc = "Move cursor to the previous split";
        };
      }
      {
        action = "<cmd>lua require('smart-splits').swap_buf_left()<CR>";
        key = "<leader><leader>h>";
        options = {
          desc = "Swap buffer to the left";
        };
      }
      {
        action = "<cmd>lua require('smart-splits').swap_buf_down()<CR>";
        key = "<leader><leader>j>";
        options = {
          desc = "Swap buffer downwards";
        };
      }
      {
        action = "<cmd>lua require('smart-splits').swap_buf_up()<CR>";
        key = "<leader><leader>k>";
        options = {
          desc = "Swap buffer upwards";
        };
      }
      {
        action = "<cmd>lua require('smart-splits').swap_buf_right()<CR>";
        key = "<leader><leader>l>";
        options = {
          desc = "Swap buffer to the right";
        };
      }
    ];
  };
}
