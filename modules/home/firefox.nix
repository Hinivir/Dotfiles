{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.firefox;
in {
  options.firefox = {
    enable = lib.mkEnableOption "Enable firefox";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      firefox
    ];
  };
}
