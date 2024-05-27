{ inputs, ... }: {
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

        binds = {
          cheatsheet.enable = true;
          whichKey.enable = true;
        };

        filetree.nvimTree.enable = true;

        telescope.enable = true;

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
      };
    };
  };
}
