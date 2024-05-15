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
    };
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };

}