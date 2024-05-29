{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.neovim-flake.homeManagerModules.default
  ];

  programs.neovim-flake = {
    enable = true;
    settings = {
      vim = {
        useSystemClipboard = true;
        theme = {
          enable = true;
          name = "catppuccin";
          style = "mocha";
        };

        languages = {
          nix = {
            enable = true;
            lsp.enable = true;
            extraDiagnostics.enable = true;
            format.enable = true;
            treesitter.enable = true;
          };

          rust = {
            enable = true;
            lsp.enable = true;
            treesitter.enable = true;
          };

          clang = {
            enable = true;
            lsp.enable = true;
            treesitter.enable = true;
            dap.enable = true;
            cHeader = true;
          };

          ts = {
            enable = true;
            lsp.enable = true;
            treesitter.enable = true;
            format.enable = true;
          };

          python = {
            enable = true;
            lsp.enable = true;
            treesitter.enable = true;
            format.enable = true;
          };

          markdown = {
            enable = true;
            lsp.enable = true;
            treesitter.enable = true;
            format.enable = true;
          };

          html = {
            enable = true;
            treesitter.enable = true;
          };

          lua = {
            enable = true;
            lsp.enable = true;
            treesitter.enable = true;
          };

          enableFormat = true;
          enableLSP = true;
          enableTreesitter = true;
        };

        autopairs.enable = true;

        binds = {
          cheatsheet.enable = true;
          whichKey.enable = true;
        };

        filetree.nvimTree.enable = false;

        telescope.enable = true;

        mouseSupport = "a";

        notes = {
            todo-comment.enable = true;
        };

        notify.nvim-notify.enable = true;

        terminal.toggleterm = {
          enable = true;
          lazygit.enable = true;
        };

        statusline.lualine = {
          enable = true;
        };

        ui = {
          noice.enable = true;
        };

        extraPlugins = {
          hover = {
            package = pkgs.vimPlugins.hover-nvim;
            setup = ''
              require("hover").setup {
                    init = function()
                        -- Require providers
                        require("hover.providers.lsp")
                        require('hover.providers.gh')
                        require('hover.providers.gh_user')
                        require('hover.providers.jira')
                        -- require('hover.providers.dap')
                        require('hover.providers.man')
                        require('hover.providers.dictionary')
                    end,
                    preview_opts = {
                        border = 'single'
                    },
                    -- Whether the contents of a currently open hover window should be moved
                    -- to a :h preview-window when pressing the hover keymap.
                    preview_window = false,
                    title = true,
                    mouse_providers = {
                        'LSP'
                    },
                    mouse_delay = 1000
                }
            '';
          };

          plenary = {
            package = pkgs.vimPlugins.plenary-nvim;
          };

          nvim-web-devicons = {
            package = pkgs.vimPlugins.nvim-web-devicons;
          };

          nui = {
            package = pkgs.vimPlugins.nui-nvim;
          };

          neo-tree = {
            package = pkgs.awesomeNeovimPlugins.neo-tree-nvim;
            setup = ''

            '';
          };

          edgy = {
            package = pkgs.vimPlugins.edgy-nvim;
            setup = ''
              require("edgy").setup(opts?)
            '';
          };
        };

        maps.normal = {
          "<leader>hh" = {
            action = "<cmd>lua require('hover').hover()<CR>";
            silent = true;
            desc = "hover.nvim";
          };
          "<leader>hg" = {
            action = "<cmd>lua require('hover').hover_select()<CR>";
            silent = true;
            desc = "hover.nvim (select)";
          };
          "<leader>nn" = {
            action = "<cmd> Neotree position=left toggle";
            silent = true;
            desc = "Open Neotree left";
          };
          "<leader>nf" = {
            action = "<cmd> Neotree focus";
            silent = true;
            desc = "Focus Neotree";
          };
        };
      };
    };
  };
}
