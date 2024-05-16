{
  lib,
  config,
  ...
}: let
  cfg = config.fzf;
in {
  options.fzf = {
    enable = lib.mkEnableOption "Enable fzf";
  };

  config = lib.mkIf cfg.enable {
    programs.fzf = {
      enable = true;
      enableZshIntegration = lib.mkIf config.zsh.enable;
      tmux.enbleShellIntegration = lib.mkIf config.tmux.enable;
    };
  };
}
