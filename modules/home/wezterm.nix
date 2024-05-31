{
  config,
  lib,
  ...
}: let
  cfg = config.wezterm;
in {
  options.wezterm = {
    enable = lib.mkEnableOption "Enable wezterm";
  };

  config = lib.mkIf cfg.enable {
    programs.wezterm = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      extraConfig = ''
        local wezterm = require("wezterm")

        local config = {}

        wezterm.font("JetBrainsMono Nerd Font"),
        config.window_frame = { font_size = 16.0, }
        config.color_scheme = "Catppuccin Mocha",
        config.hide_tab_bar_if_only_one_tab = true
        config.use_fancy_tab = true
        config.window_decorations = "RESIZE"

        return config
      '';
    };
  };
}
