{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.system.virtualisation.docker;
in {
  options.system.virtualisation.docker = {
    enable = mkEnableOption "enable docker";
  };

  config = mkIf cfg.enable {
    virtualisation.docker.enable = true;
    users.users.viktor.extraGroups = ["docker"];

    environment.systemPackages = with pkgs; [
      docker
      docker-compose
    ];
  };
}
