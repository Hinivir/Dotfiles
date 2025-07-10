{
  pkgs,
  inputs,
  config,
  ...
}: let
  theme = "oxocarbon-dark";
in {
  imports = [
    ./hardware-configuration.nix
    inputs.nixos-cosmic.nixosModules.default
    "${builtins.fetchGit {
      url = "https://github.com/cgrohs27/nixos-hardware.git";
      rev = "64bb927d282e67f9b37be2b5c1bd8ce3b73178d2";
    }}/asus/zephyrus/ga403"
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_6_13;
    kernelModules = ["v4l2loopback"]; # Autostart kernel modules on boot
    extraModulePackages = with config.boot.kernelPackages; [v4l2loopback]; # loopback module to make OBS virtual camera work
    supportedFilesystems = ["ntfs"];
    loader = {
      systemd-boot = {
        enable = true;
        editor = false;
      };
      timeout = 10;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      grub = {
        enable = false;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
        configurationLimit = 8;
      };
    };
  };

  hardware = {
    nvidia = {
      nvidiaSettings = true;
      powerManagement.enable = true;
      modesetting.enable = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
    opengl = {
      enable = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [nvidia-vaapi-driver];
    };
  };

  environment = {
    variables = {
      EDITOR = "nvim";
      LIBVA_DRIVER_NAME = "nvidia";
      XDG_SESSION_TYPE = "wayland";
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      __GL_GSYNC_ALLOWED = "1";
      __GL_VRR_ALLOWED = "0"; # Controls if Adaptive Sync should be used. Recommended to set as “0” to avoid having problems on some games.
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      CUDA_CACHE_PATH = "$XDG_CACHE_HOME/nv";
      GTK_THEME = "Catppuccin-Mocha-Compact-Blue-dark";
    };
    sessionVariables = {
      NIXOS_OZONE_WL = "1"; # Hint electron apps to use wayland
      WLR_NO_HARDWARE_CURSORS = "1"; # Fix cursor rendering issue on wlr nvidia.
      DEFAULT_BROWSER = "${pkgs.brave}/bin/brave"; # Set default browser
    };
    shellAliases = {nvidia-settings = "nvidia-settings --config='$XDG_CONFIG_HOME'/nvidia/settings";};
  };

  networking = {
    networkmanager.enable = true;
    enableIPv6 = false;
    dhcpcd.wait = "background";
    dhcpcd.extraConfig = "noarp";
    hostName = "Omikami";
  };

  users = {
    users = {
      viktor = {
        isNormalUser = true;
        description = "viktor";
        initialPassword = "123456";
        shell = pkgs.zsh;
        extraGroups = ["networkmanager" "wheel" "input" "docker" "kvm" "libvirtd"];
      };
    };
  };

  security = {
    sudo = {
      enable = true;
    };
    doas = {
      enable = true;
      extraRules = [
        {
          users = ["viktor"];
          keepEnv = true;
          persist = true;
        }
      ];
    };
  };

  programs = {
    zsh.enable = true;
    nix-ld.enable = true;
    steam.enable = true;
    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "/home/viktor/dotfiles";
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-wlr
    ];
  };

  virtualisation = {
    docker.rootless = {
      enable = true;
      setSocketVariable = true;
    };
    libvirtd.enable = true;
  };

  time.timeZone = "Europe/Paris";

  i18n = {
    defaultLocale = "en_US.UTF-8";

    extraLocaleSettings = {
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

  nix = {
    package = pkgs.nixVersions.latest;
    extraOptions = "experimental-features = nix-command flakes";
    settings = {
      auto-optimise-store = true;
      http-connections = 50;
      warn-dirty = false;
      log-lines = 50;
      sandbox = "relaxed";
    };
    gc = {
      automatic = false;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  systemd = {
    services.NetworkManager-wait-online.enable = false;
    extraConfig = ''
      DefaultTimeoutStopSec=10s
    '';
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    htop
    fastfetch
    direnv
    neovim
    nh
    nvd
    neovide
    zed-editor
    nautilus
    seahorse
    gnome-disk-utility
    git
    docker-compose
    acpi
    firefox
  ];

  security.polkit.enable = true;

  console.keyMap = "fr";

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  services = {
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      wireplumber.enable = true;
      jack.enable = false;
      pulse.enable = true;
      audio.enable = true;
    };

    fstrim.enable = true;
    sshd.enable = true;
    libinput = {
      enable = true;
      mouse = {
        accelProfile = "flat";
      };
      touchpad = {
        accelProfile = "flat";
      };
    };
    desktopManager = {
      cosmic.enable = true;
    };
    displayManager.cosmic-greeter.enable = true;
    xserver = {
      enable = true;
      displayManager = {
        sessionCommands = ''
          xset r rate 150 25
          xrandr --output DP-0 --mode 2240x1400 --rate 60 --primary
          nitrogen --restore
        '';
      };
      xkb = {
        variant = "";
        layout = "fr";
      };
      videoDrivers = ["nvidia"];
    };
    logmein-hamachi.enable = false;
    flatpak.enable = false;
    autorandr = {
      enable = true;
      profiles = {
        Omikami = {
          config = {
            DP-0 = {
              enable = true;
              primary = true;
              mode = "2240x1400";
              rate = "60.00";
              position = "0x0";
            };
          };
        };
      };
    };
    printing.enable = true;
  };

  system.stateVersion = "23.11";
}
