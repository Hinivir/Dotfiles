{
  imports = [
    ./hardware.nix
    ./users.nix
  ];

  shinto = {
    profiles = {
      graphical.enable = true;
      workstation.enable = true;
    };

    device = {
      cpu = "amd";
      gpu = "nvidia";
      monitors = [ "DP-2" ];
      capabilities = {
        tpm = true;
        bluetooth = true;
      };
      keyboard = "fr";
    };

    system = {
      boot = {
        loader = "systemd-boot";
        secureBoot = true;
        enableKernelTweaks = true;
        loadRecommendedModules = true;

        initrd = {
          enableTweaks = true;
          optimizeCompressor = true;
        };
      };

      bluetooth.enable = true;
      printing.enable = true;
      emulation.enable = true;

      networking = {
        optimizeTcp = true;
        wirelessBackend = "iwd";
      };
    };
  };
}
