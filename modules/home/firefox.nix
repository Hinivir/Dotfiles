{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.firefox;
in {
  options.sesh = {
    enable = lib.mkEnableOption "Enable firefox";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      firefox
    ];
  };
}
