{
  pkgs,
  inputs,
  ...
}: {
  home.username = "viktor";
  home.homeDirectory = "/home/viktor";

  home.stateVersion = "23.11";

  imports = [
    ../../modules/home/default.nix
  ];

  inputs.stylix.polarity = "dark";
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

  alacritty = {
    enable = true;
    theme = pkgs.alacritty-theme.catppuccin_mocha;
  };
  fzf.enable = true;
  git = {
    enable = true;
    name = "Viktor Bruggeman";
    email = "viktor.bruggeman@epitech.eu";
  };
  tmux.enable = true;
  zoxide.enable = true;
  zsh.enable = true;

  home.packages = [
    pkgs.eza
    pkgs.bat
    pkgs.lazygit
  ];

  home.file = {};

  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "firefox";
    TERMINAL = "alacritty";
    VISUAL = "nvim";
  };

  programs.home-manager.enable = true;
}
