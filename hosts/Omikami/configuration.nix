{
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos
    inputs.nixos-cosmic.nixosModules.default
  ];

  stylix = {
    autoEnable = true;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    image = ./../../../Pictures/wall/jMYaGpT.jpeg;
  };

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

    virtualisation.docker.enable = true;
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

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  services = {
    xserver.enable = true;
    xserver.displayManager.sddm.wayland.enable = true;
    #displayManager.sddm.enable = true;
    #displayManager.sddm.wayland.enable = true;
    desktopManager.plasma6.enable = true;
    desktopManager.cosmic.enable = true;
    displayManager.cosmic-greeter.enable = true;
  };
  services.gnome.gnome-settings-daemon.enable = true;
  services.udev.packages = with pkgs; [
    gnome.gnome-settings-daemon
  ];
  services.gnome = {
    glib-networking.enable = true;
    evolution-data-server.enable = true;

    # optional to use google/nextcloud calendar
    gnome-online-accounts.enable = true;

    # optional to use google/nextcloud calendar
    gnome-keyring.enable = true;

    gnome-remote-desktop.enable = lib.mkForce false;
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config = {
      common.default = ["gtk"];
      hyprland.default = ["gtk" "hyprland"];
    };
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-wlr
      pkgs.xdg-desktop-portal-hyprland
    ];
  };

  services.ollama = {
    enable = true;
    acceleration = "cuda";
  };

  programs.steam = {
    enable = true;
  };

  programs.nix-ld.enable = true;

  services.xserver.xkb = {
    layout = "fr";
    variant = "";
  };

  console.keyMap = "fr";

  services.libinput.enable = true;

  programs.zsh.enable = true;

  users.users.viktor = {
    isNormalUser = true;
    description = "Viktor Bruggeman";
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.zsh;
  };

  users.defaultUserShell = pkgs.zsh;

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

  nix.trustedUsers = ["root" "@wheel"];

  system.stateVersion = "23.11";
}
