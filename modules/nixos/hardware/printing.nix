{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.hardware.printing;
in {
  options.hardware.printing = {
    enable = lib.mkEnableOption "Enable printing support";
  };

  config = lib.mkIf cfg.enable {
    services.printing.enable = true;
  };
}
