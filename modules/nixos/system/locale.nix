{ lib, config, pkgs, ... }: 

let
  cfg = config.system.locale;
in {
  options.system.locale = {
    defaultLocale = {
      type = lib.types.str;
      default = "en_US.UTF-8";
    };
    extraLocales = {
      type = lib.types.listOf lib.types.str;
      default = {};
    };
  };

  config = {
    system = {
      locale = {
        defaultLocale = cfg.defaultLocale;
        extraLocales = cfg.extraLocales;
      };
    };
  };
}