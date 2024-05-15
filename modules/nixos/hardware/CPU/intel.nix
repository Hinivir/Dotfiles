{ lib, config, pkgs, ... }: 

let
  cfg = config.hardware.CPU.intel;
in {
  options.CPU.intel = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable intel CPU support.";
    };
  };

  config = lib.mkIf cfg.enable {
    hardware.cpu.intel.updateMicrocode = true;
    boot = {
      kernelModules = ["kvm-intel"];
      kernelParams = ["i915.fastboot=1" "enable_gvt=1"];
    };

    environment.systemPackages = with pkgs; [intel-gpu-tools];
  };

}