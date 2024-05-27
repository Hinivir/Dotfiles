{
  pkgs,
  inputs,
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

  services.xserver.enable = true;
  services.xserver.displayManager.sddm.wayland.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;
  #services.desktopManager.cosmic.enable = true;
  #services.displayManager.cosmic-greeter.enable = true;

  services.gnome.gnome-keyring.enable = true;
  services.gnome.gnome-online-accounts.enable = true;
  services.gnome.gnome-settings-daemon.enable = true;

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

  nix.trustedUsers = [ "root" "@wheel" ];

  system.stateVersion = "23.11";
}
