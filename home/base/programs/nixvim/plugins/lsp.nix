{ ... }:
{
  programs.nixvim = {
    plugins = {
      treesitter = {
        enable = true;
        settings = {
          auto_install = true;
          highlight = {
            additional_vim_regex_highlighting = true;
            custom_captures = { };
            enable = true;
          };
          indent = {
            enable = true;
          };
          parser_install_dir = {
            __raw = "vim.fs.joinpath(vim.fn.stdpath('data'), 'treesitter')";
          };
        };
      };
      treesitter-context.enable = true;
      indent-blankline.enable = true;
      lsp = {
        enable = true;
        servers = {
          gopls.enable = true;
          nixd.enable = true;
          lua-ls.enable = true;
        };
        keymaps = {
          lspBuf = {
            K = "hover";
            gr = {
              action = "references";
              desc = "Go to references"; 
            };
            gi = { 
              action = "implementation";
              desc = "Go to implementation";
            };
            gt = {
              action = "type_definition";
              desc = "Go to type definition";
            };
          };
          extra = [
            {
              action = "<CMD>LspStop<Enter>";
              key = "<leader>lx";
              options = {
                desc = "Stop LSP";
              };
            }
            {
              action = "<CMD>LspStart<Enter>";
              key = "<leader>ls";
              options = {
                desc = "Start LSP";
              };
            }
            {
              action = "<CMD>LspRestart<Enter>";
              key = "<leader>lr";
              options = {
                desc = "Restart LSP";
              };
            }
            {
              action = "<CMD>Telescope lsp_definitions<Enter>";
              key = "gd";
              options = {
                desc = "Go to definitions";
              };
            }
          ];
        };
      };
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-e>" = "cmp.mapping.close()";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<S-Tab>" = ''
              cmp.mapping(function (fallback)
                local luasnip = require('luasnip')
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, {'i', 's'})
            '';
            "<Tab>" = ''
              cmp.mapping(function (fallback)
                local luasnip = require('luasnip')
                if luasnip.expandable() then
                    luasnip.expand()
                elseif cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.jumpable(1) then
                    luasnip.jump(1)
                else
                    fallback()
                end
              end, {'i', 's'})
            '';
          };

          sources =
            [ { name = "nvim_lsp"; } { name = "path"; } { name = "buffer"; } { name = "luasnip"; } ];
        };
      };
      cmp-nvim-lsp.enable = true;
      cmp-nvim-lsp-signature-help.enable = true;
      telescope = {
        enable = true;
      };

      luasnip.enable = true;
      friendly-snippets.enable = true;
    };
  };
}
