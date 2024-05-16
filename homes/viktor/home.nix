{
  config,
  pkgs,
  ...
}: {
  home.username = "viktor";
  home.homeDirectory = "/home/viktor";

  home.stateVersion = "23.11";

  imports = [
    ../../modules/home/default.nix
  ];

  alacritty.enable = true;

  home.packages = [];

  home.file = {};

  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "firefox";
    TERMINAL = "alacritty";
    VISUAL = "nvim";
  };

  programs.home-manager.enable = true;
}
