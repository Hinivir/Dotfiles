{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/nixos
    ];

  networking.hostName = "Omikami";

  system = {
    boot = {
      enable = true;
      grub = {
        enable = true;
        device = "/dev/nvme0n1p3";
      };
      systemd-boot.enable = false;
      efi.canTouchEfiVariables = true;
    };

    time.timeZone = "Europe/Paris";

    locale = {
      defaultLocale = "en_US.UTF-8";
      extraLocales = {
        LC_ADDRESS = "fr_FR.UTF-8";
        LC_IDENTIFICATION = "fr_FR.UTF-8";
        LC_MEASUREMENT = "fr_FR.UTF-8";
        LC_MONETARY = "fr_FR.UTF-8";
        LC_NAME = "fr_FR.UTF-8";
        LC_NUMERIC = "fr_FR.UTF-8";
        LC_PAPER = "fr_FR.UTF-8";
        LC_TELEPHONE = "fr_FR.UTF-8";
        LC_TIME = "fr_FR.UTF-8";
      };
    };
  };

  hardware = {
    printing.enable = true;
    sound.enable = true;
    CPU.intel.enable = true;
    GPU.nvidia.enable = true;
  };

  services.xserver.enable = true;

  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;

  services.xserver.xkb = {
    layout = "fr";
    variant = "";
  };

  console.keyMap = "fr";

  services.libinput.enable = true;

  users.users.viktor = {
    isNormalUser = true;
    description = "Viktor Bruggeman";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  nix = {
    nixpkgs.allowUnfree = true;
    experimental-features.options = [ "nix-command" "flakes" ];
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    curl
    htop
    fastfetch
    firefox
    direnv
  ];

  services.openssh.enable = true;

  system.stateVersion = "23.11";
}
