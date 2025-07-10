{
  lib,
  config,
  ...
}: let
  cfg = config.gpg;
in {
  options.gpg = {
    enable = lib.mkEnableOption "Enable gpg";
  };

  config = {
    programs.gpg = {
      enable = true;
      homedir = "${config.xdg.dataHome}/gnugpg";
      };

      scdaemonSettings.deny-admin = true;
    };
  };
}
