{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.system.font;
in {
  options.system.font = {
    enable = lib.mkEnableOption "Enable font";
  };

  config = lib.mkIf cfg.enable {
    packages = with pkgs; [
      # defaults worth keeping
      dejavu_fonts
      freefont_ttf
      gyre-fonts
      liberation_ttf # for PDFs, Roman
      unifont
      roboto

      # programming fonts
      sarasa-gothic
      (nerdfonts.override {fonts = ["Iosevka" "JetBrainsMono" "NerdFontsSymbolsOnly"];})

      # desktop fonts
      corefonts # MS fonts
      b612 # high legibility
      material-icons # used in widgets and such
      material-design-icons
      work-sans
      comic-neue
      source-sans
      inter
      lato
      lexend
      dejavu_fonts
      noto-fonts
      noto-fonts-cjk

      # emojis
      noto-fonts-color-emoji
      twemoji-color-font
      openmoji-color
      openmoji-black
    ];
  };
}
