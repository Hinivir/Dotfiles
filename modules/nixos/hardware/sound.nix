{ lib, config, pkgs, ... }: 

let
  cfg = config.hardware.sound;
in {
  options.hardware.sound = {
    enable = lib.mkEnableOption "Enable sound support";
  };

  config = lib.mkIf cfg.enable {
    hardware.pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
    };
    services.pipewire = {
      enable = true;
      package = pkgs.pipewire;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };

}