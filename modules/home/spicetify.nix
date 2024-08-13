{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.spicetify;
  spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
in {
  imports = [inputs.spicetify-nix.homeManagerModules.default];

  options.spicetify = {
    enable = lib.mkEnableOption "Enable spicetify";
  };

  config = lib.mkIf cfg.enable {
    programs.spicetify = {
      enable = true;
      enabledExtensions = with spicePkgs.extensions; [
        powerBar
        playlistIcons
        fullAppDisplay
      ];
    };
  };
}
