{
  config,
  lib,
  ...
}: let
  cfg = config.foot;
in {
  options.foot = {
    enable = lib.mkEnableOption "Enable foot";
  };

  config = lib.mkIf cfg.enable {
    programs.foot = {
      enable = true;
      settings = {
        main = {
          term = "xterm-256color";

          font = "JetBrainsMono Nerd Font:size=11";
          dpi-aware = "yes";
        };
      };
    };
  };
}
