{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos
    inputs.nixos-cosmic.nixosModules.default
  ];

  networking.hostName = "Omikami";

  networking.networkmanager.enable = true;

  system = {
    boot = {
      enable = true;
      bootloader = "grub";
      device = "/dev/nvme0n1p3";
      efiSupport = true;
      useOSProber = true;
      canTouchEfiVariables = true;
    };

    font.enable = true;

    time.timeZone = "Europe/Paris";
  };

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
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

  hardware = {
    printing.enable = true;
    sound = {
      enable = true;
      use = "pipewire";
    };
    GPU.nvidia.enable = true;
  };

  virtualisation.docker.enable = true;

  services.xserver.enable = true;

  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;
  #services.desktopManager.cosmic.enable = true;
  #services.displayManager.cosmic-greeter.enable = true;

  services.xserver.xkb = {
    layout = "fr";
    variant = "";
  };

  console.keyMap = "fr";

  services.libinput.enable = true;

  users.users.viktor = {
    isNormalUser = true;
    description = "Viktor Bruggeman";
    extraGroups = ["networkmanager" "wheel"];
  };

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    curl
    htop
    fastfetch
    firefox
    direnv
    neovim
    nh
    nvd
  ];

  services.openssh.enable = true;

  system.stateVersion = "23.11";
}
