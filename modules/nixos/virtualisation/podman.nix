{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.virtualisation.podman;
in {
  options.virtualisation.podman = {
    enable = mkEnableOption "enable podman";
  };

  config = mkIf cfg.enable {
    virtualisation.podman.enable = true;

    environment.systemPackages = with pkgs; [
      podman
      podman-desktop
      podman-compose
    ];
  };
}
