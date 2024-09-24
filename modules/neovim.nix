{
  config,
  inputs,
  lib,
  pkgs,
  username,
  ...
}:
let
  cfg = config.modules.neovim;
in
{
  options.modules.neovim.enable = lib.mkEnableOption "neovim";

  config = lib.mkIf cfg.enable {
    environment.sessionVariables = {
      EDITOR = "nvim";
    };

    home-manager.users.${username} = {
      imports = [ inputs.nvf.homeManagerModules.default ];

      programs.nvf = {
        enable = true;
        settings.vim = {
          viAlias = true;
          vimAlias = true;
          enableLuaLoader = true;
          preventJunkFiles = true;
          tabWidth = 4;
          autoIndent = false;
          useSystemClipboard = true;

          luaConfigPost = lib.concatStrings [
            ''
              vim.opt.formatoptions:remove('c')
              vim.opt.formatoptions:remove('r')
              vim.opt.formatoptions:remove('o')
            ''
          ];

          theme = {
            enable = true;
            name = "catppuccin";
            style = "frappe";
          };

          maps = {
            normal = {
              "<leader>t" = {
                action = "<CMD>Neotree toggle<CR>";
                silent = true;
              };
            };
          };
          statusline.lualine = {
            enable = true;
            theme = "catppuccin";
          };

          lsp = {
            enable = true;
            lspSignature.enable = true;
            lspconfig.enable = true;
            formatOnSave = true;
            mappings = {
              addWorkspaceFolder = "<leader>wa";
              codeAction = "<leader>a";
              goToDeclaration = "gD";
              goToDefinition = "gd";
              hover = "K";
              listImplementations = "gi";
              listReferences = "gr";
              listWorkspaceFolders = "<leader>wl";
              nextDiagnostic = "<leader>k";
              previousDiagnostic = "<leader>j";
              openDiagnosticFloat = "<leader>e";
              removeWorkspaceFolder = "<leader>wr";
              renameSymbol = "<leader>r";
              signatureHelp = "<C-k>";
            };
          };

          autocomplete = {
            enable = true;
            alwaysComplete = true;
          };

          autopairs.enable = true;
          languages = {
            enableExtraDiagnostics = true;
            enableFormat = true;
            enableLSP = true;
            enableTreesitter = true;

            nix.enable = true;
            clang.enable = true;
            python.enable = true;
          };

          treesitter = {
            enable = true;
            fold = true;
            context.enable = true;
            grammars = [
              pkgs.vimPlugins.nvim-treesitter.builtGrammars.nix
              pkgs.vimPlugins.nvim-treesitter.builtGrammars.c
              pkgs.vimPlugins.nvim-treesitter.builtGrammars.python
            ];
          };

          binds.whichKey.enable = true;
          visuals.nvimWebDevicons.enable = true;

          filetree.neo-tree = {
            enable = true;
            setupOpts = {
              git_status_async = true;
            };
          };

          telescope.enable = true;
        };
      };
    };
  };
}
