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
      theme = spicePkgs.theme.catppuccin;
      colorscheme = "mocha";
      enabledExtensions = with spicePkgs.extensions; [
        powerBar
        playlistIcons
        fullAppDisplay
      ];
    };
  };
}
