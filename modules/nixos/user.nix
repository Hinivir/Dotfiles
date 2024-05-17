{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf mkOption types;
  cfg = config.virtualisation.docker;
in {
  options.user = {
    name = mkOption {
      type = types.str;
      default = "viktor";
      description = "the username";
    };
  };

  config = {
  };
}
