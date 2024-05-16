{
  lib,
  config,
  ...
}: let
  cfg = config.git;
in {
  options = {
    enable = lib.mkEnableOption "Enable git";
    name = lib.mkOption {
      type = lib.types.str;
      default = "Viktor Bruggeman";
      description = "Git name";
    };
    email = lib.mkOption {
      type = lib.types.str;
      default = "viktor.bruggeman@epitech.eu";
      description = "Git user email";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;
      userName = cfg.name;
      userEmail = cfg.email;
      signing.key = null;
      signing.signByDefault = true;

      extraConfig = {
        pull = {
          rebase = true;
        };
        init = {
          defaultBranch = "main";
        };
      };
    };
  };
}
