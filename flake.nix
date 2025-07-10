{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.xz";

    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    flake-utils = {
      url = "github:numtide/flake-utils";
    };

    easy-hosts = {
      type = "github";
      owner = "tgirlcloud";
      repo = "easy-hosts";
    };

    lanzaboote = {
      type = "github";
      owner = "nix-community";
      repo = "lanzaboote";

      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        pre-commit-hooks-nix.follows = "";
        flake-compat.follows = "";
      };
    };

    sops = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fht-compositor = {
      url = "github:nferhat/fht-compositor";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fht-share-picker = {
      type = "github";
      owner = "nferhat";
      repo = "fht-share-picker";
      ref = "gtk-rewrite";

      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        rust-overlay.follows = "";
      };
    };

    catppuccin.url = "github:catppuccin/nix";

    my-nvim.url = "github:Hinivir/nvim";

    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ecsls.url = "github:Sigmapitech/ecsls"; # Epitech codding style language server

    jerry.url = "github:justchokingaround/jerry";
    lobster.url = "github:justchokingaround/lobster";

    nyxpkgs.url = "github:NotAShelf/nyxpkgs";

    anyrun.url = "github:anyrun-org/anyrun";
    anyrun-nixos-options = {
      url = "github:n3oney/anyrun-nixos-options";
      inputs = {
        flake-parts.follows = "flake-parts";
      };
    };

    firefox = {
      url = "github:nix-community/flake-firefox-nightly";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = import inputs.nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };
  in {
    nixosConfigurations.Omikami = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/Omikami/configuration.nix
        inputs.home-manager.nixosModules.default
      ];
    };

    nixosConfigurations.OmikamiWSL = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/OmikamiWSL/configuration.nix
        inputs.home-manager.nixosModules.default
        inputs.nixos-wsl.nixosModules.wsl
      ];
    };

    homeConfigurations = {
      viktor = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./homes/viktor/home.nix
        ];
        extraSpecialArgs = {
          inherit inputs;
        };
      };
    };
  };
}
