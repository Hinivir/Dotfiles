{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    inputs.nvf.homeManagerModules.default
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
      };

      autocomplete = {
        enable = true;
        mappings.scrollDocsUp = "<C-b>";
      };

      binds = {
        cheatsheet.enable = true;
        whichKey.enable = true;
      };

      comments.comment-nvim.enable = true;
      debugger.nvim-dap = {
        enable = true;
        ui.enable = true;
      };

      autopairs.enable = true;

      statusline.lualine = {
        enable = true;
      };
      dashboard.startify = {
        enable = true;
      };

      notify.nvim-notify.enable = true;

      telescope.enable = true;
      terminal.toggleterm = {
        enable = true;
        lazygit.enable = true;
      };

      ui = {
        noice.enable = true;
      };

      git.enable = true;

      languages = {
	      nix = {
          enable = true;
          lsp.enable = true;
          extraDiagnostics.enable = true;
          format.enable = true;
          tressitter.enable = true;
        };

        rust = {
          enable = true;
          lsp.enable = true;
          tressitter.enable = true;
        };

        clang = {
          enable = true;
          lsp.enable = true;
          tressitter.enable = true;
          dap.enable = true;
          cHeader.enable = true;
        };

	      ts = {
          enable = true;
          lsp.enable = true;
          tressitter.enable = true;
          format.enable = true;
        };

	      python = {
          enable = true;
          lsp.enable = true;
          tressitter.enable = true;
          format.enable = true;
        };

        markdown = {
          enable = true;
          lsp.enable = true;
          tressitter.enable = true;
          format.enable = true;
        };

	      html = {
          enable = true;
          lsp.enable = true;
          tressitter.enable = true;
          format.enable = true;
        };

        lua = {
          enable = true;
          lsp.enable = true;
          tressitter.enable = true;
          format.enable = true;
        };

        enableFormat = true;
        enableLSP = true;
        enableTreesitter = true;
      };
    };
  };
}