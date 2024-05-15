{ lib, config, pkgs, ... }: 

let
  cfg = config.hardware.GPU.nvidia;
in {
  options.hardware.GPU.nvidia = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable NVIDIA GPU support.";
    };
  };

  config.hardware.GPU.nvidia = lib.mkIf cfg.enable {
    hardware.opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };

    services.xserver.videoDrivers = ["nvidia"];

    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
    };
  };
}