{ lib, config, pkgs, ... }: 

let
  cfg = config.hardware.CPU.amd;
in {
  options.CPU.amd = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable amd CPU support.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [pkgs.amdctl];

    hardware.cpu.amd.updateMicrocode = true;
    boot = mkMerge [
      {
        kernelModules = [
          "kvm-amd" # amd virtualization
          "amd-pstate" # load pstate module in case the device has a newer gpu
          "zenpower" # zenpower is for reading cpu info, i.e voltage
          "msr" # x86 CPU MSR access device
        ];
        extraModulePackages = [config.boot.kernelPackages.zenpower];
      }
  };

}