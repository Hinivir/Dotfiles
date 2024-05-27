{pkgs, ...}: {
  home.username = "viktor";
  home.homeDirectory = "/home/viktor";

  home.stateVersion = "23.11";

  imports = [
    ../../modules/home/default.nix
  ];

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
  hyprland.enable = true;
  sesh.enable = true;

  home.packages = [
    pkgs.eza
    pkgs.bat
    pkgs.fd
    pkgs.ripgrep
    pkgs.jq
    pkgs.lazygit
    pkgs.python3
    pkgs.gnome.gnome-settings-daemon
    pkgs.google-chrome
    pkgs.awscli2
    pkgs.vscode
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
