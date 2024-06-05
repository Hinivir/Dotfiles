{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.hardware.sound;
in {
  options.hardware.sound = {
    enable = lib.mkEnableOption "Enable sound support";
    use = lib.mkOption {
      type = lib.types.enum ["pulseaudio" "pipewire"];
      default = "pipewire";
      description = "Select the sound system to use";
    };
  };

  config = lib.mkIf cfg.enable {
    hardware.pulseaudio = {
      enable = cfg.use == "pulseaudio";
    };
    services.pipewire = {
      enable = cfg.use == "pipewire";
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };
  };
}
