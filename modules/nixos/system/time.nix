{ lib, config, pkgs, ... }:

let
  cfg = config.system.time;
in {
  options.system.time = {
    timeZone = lib.mkOption {
      type = lib.types.string;
      default = "Europe/Paris";
      description = "The time zone to use for the system clock.";
    };
  };

  config = {
    system.time.timeZone = cfg.timeZone;
  };
}
