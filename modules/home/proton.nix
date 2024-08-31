{
  lib,
  config,
  ...
}: let
  cfg = config.proton;
in {
  options.proton = {
    enable = lib.mkEnableOption "Enable proton";
  };

  config = {
    home.packages = with pkgs; [
      protonvpn-gui
      protonvpn-cli_2
      protonmail-desktop
    ];
  };
}
