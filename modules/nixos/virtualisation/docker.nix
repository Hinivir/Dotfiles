{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.virtualisation.docker;
in {
  options.virtualisation.docker = {
    enable = mkEnableOption "enable docker";
  };

  config = mkIf cfg.enable {
    virtualisation.docker.enable = true;
    users.users.${config.user}.extraGroups = ["docker"];

    environment.systemPackages = with pkgs; [
      docker
      docker-compose
    ];
  };
}
