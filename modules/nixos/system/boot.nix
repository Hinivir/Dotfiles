{ config, lib, pkgs, ... }:

let
  cfg = config.system.boot;
in
{
  options.system.boot = {
    enable = lib.mkEnableOption "Enable boot loader";

    bootloader = lib.mkOption {
      type = lib.types.enum [ "grub" "systemd-boot" ];
      default = "grub";
      description = "The bootloader to use.";
    };

    device = lib.mkOption {
      type = lib.types.str;
      default = "/dev/sda";
      description = "The device to install the bootloader on.";
    };

    efiSupport = lib.mkEnableOption "Enable EFI support";
    useOSProber = lib.mkEnableOption "Use os-prober to detect other operating systems";
    canTouchEfiVariables = lib.mkEnableOption "Allow writing to EFI variables";
  };

  config = lib.mkIf cfg.enable {
    boot.loader = {
      grub = {
        enable = cfg.bootloader == "grub";
        device = cfg.device;
        efiSupport = cfg.efiSupport;
        useOSProber = cfg.useOSProber;
      };

      systemd-boot = {
        enable = cfg.bootloader == "systemd-boot";
        device = cfg.device;
      };

      efi = {
        canTouchEfiVariables = cfg.canTouchEfiVariables;
      };
    };
  };
}