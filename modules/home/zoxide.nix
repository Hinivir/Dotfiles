{
  config,
  lib,
  ...
}: let
  cfg = config.zoxide;
in {
  options.zoxide = {
    enable = lib.mkEnableOption "Enable zoxide";
  };

  config = lib.mkIf cfg.enable {
    programs.zoxide = {
      enable = true;
      enableZshIntegration = lib.mkIf config.zsh.enable;
      options = ["--cmd cd"];
    };
  };
}
