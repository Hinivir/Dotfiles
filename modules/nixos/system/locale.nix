{ lib, config, pkgs, ... }: 

let
  cfg = config.system.locale;
in {
  options.system.locale = {
    defaultLocale = {
      type = types.str;
      default = "en_US.UTF-8";
    };
    extraLocales = {
      type = types.listOf types.str;
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