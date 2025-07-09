{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.discord;
in {
  options.discord = {
    enable = lib.mkEnableOption "Enable discord";
  };

  config = lib.mkIf cfg.enable {
  };
}
