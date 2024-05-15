{ lib, config, pkgs, ... }: 

let
  cfg = config.hardware.GPU.amd;
in {
  options.GPU.amd = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable AMD GPU support.";
    };
  };

  config = lib.mkIf cfg.enable {
    services.xserver.videoDrivers = lib.mkDefault ["modesetting" "amdgpu"];

    # enable amdgpu kernel module
    boot = {
      initrd.kernelModules = ["amdgpu"]; # load amdgpu kernel module as early as initrd
      kernelModules = ["amdgpu"]; # if loading somehow fails during initrd but the boot continues, try again later
    };

    environment.systemPackages = [pkgs.nvtopPackages.amd];

    # enables AMDVLK & OpenCL support
    hardware.opengl = {
      extraPackages = with pkgs;
        [
          amdvlk

          # mesa
          mesa

          # vulkan
          vulkan-tools
          vulkan-loader
          vulkan-validation-layers
          vulkan-extension-layer
        ]
        ++ (
          # this is a backwards-compatible way of loading appropriate opencl packages
          # in case the host runs an older revision of nixpkgs
          if pkgs ? rocmPackages.clr
          then with pkgs.rocmPackages; [clr clr.icd]
          else with pkgs; [rocm-opencl-icd rocm-opencl-runtime]
        );

      extraPackages32 = [pkgs.driversi686Linux.amdvlk];
    };
  };

}