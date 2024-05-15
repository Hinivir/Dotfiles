{ lib, config, pkgs, ... }: 

let
  cfg = config.system.time;
in {
  options.system.time = {
    timeZone = lib.mkOption {
      type = lib.types.string;
      default = "UTC";
      description = "The time zone to use for the system clock.";
    };
  };

  config = {
    timeZone = cfg.timeZone;
  };
}