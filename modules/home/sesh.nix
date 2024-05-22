{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.sesh;
in {
  options.sesh = {
    enable = lib.mkEnableOption "Enable sesh";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      sesh
      gum
    ];
    home.shellAlias = {
      slist = ''sesh connect "$(sesh list -i | gum filter --limit 1 --placeholder 'Pick a sesh' --prompt='⚡')"'';
    };
  };
}
