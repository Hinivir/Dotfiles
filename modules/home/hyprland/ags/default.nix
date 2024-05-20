{
  inputs,
  pkgs,
  lib,
  ...
}: {
  imports = [inputs.ags.homeManagerModules.default];
  programs.ags = {
    enable = true;

    # null or path, leave as null if you don't want hm to manage the config
    configDir = null;

    # additional packages to add to gjs's runtime
    extraPackages = with pkgs; [
      gtksourceview
      webkitgtk
      accountsservice
      inotify-tools
      gtk3
      bash
      brightnessctl
      coreutils
      gawk
      gvfs
      imagemagick
      libnotify
      procps
      ripgrep
      slurp
      sysstat
      python311Packages.requests
      pavucontrol
      networkmanagerapplet
      blueman
    ];
  };
}
