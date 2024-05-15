{ lib, config, pkgs, ... }: 

let
  cfg = config.system.boot;
in {
  options.system.boot = {
    enable = lib.mkEnableOption "Enable boot loader";
    grub = {
      enable = lib.mkEnableOption "Enable GRUB";
      device = lib.mkOption {
        type = lib.types.str;
        default = "/dev/sda";
        description = "The device to install GRUB on";
      };
      efiSupport = lib.mkEnableOption "Enable EFI support";
      useOSProber = lib.mkEnableOption "Use os-prober to detect other operating systems";
    };
    systemd-boot = {
      enable = lib.mkEnableOption "Enable systemd-boot";
      device = lib.mkOption {
        type = lib.types.str;
        default = "/dev/sda";
        description = "The device to install systemd-boot on";
      };
    };
    efi.canTouchEfiVariables = lib.mkEnableOption "Allow writing to EFI variables";
  };

  config = lib.mkIf cfg.enable {
    system.boot = lib.mkIf cfg.enable {
      grub = lib.mkIf cfg.grub.enable {
        boot.loader.grub = {
          enable = true;
          version = 2;
          device = "/dev/sda";
          efiSupport = true;
          useOSProber = true;
        };
      };

      systemd-boot = lib.mkIf cfg.systemd-boot.enable {
        boot.loader.systemd-boot = {
          enable = true;
          device = "/dev/sda";
        };
      };

      efi.canTouchEfiVariables = cfg.efi.canTouchEfiVariables;
    };
  };
}