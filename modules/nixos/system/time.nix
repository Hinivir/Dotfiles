{ lib, config, pkgs, ... }: 

let
  cfg = config.system.time;
in {
  options.system.time = {
    timeZone = lib.mkOption "UTC" "string" "Time zone to use for the system clock";
  };

  config = {
    timeZone = cfg.timeZone;
  };
}