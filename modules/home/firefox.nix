{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  cfg = config.firefox;
in {
  options.firefox = {
    enable = lib.mkEnableOption "Enable firefox";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      inputs.firefox.packages.${pkgs.system}.firefox-nightly-bin
    ];
  };
}
