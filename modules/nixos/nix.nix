{ lib, config, pkgs, ... }: 

let
  cfg = config.nix;
in {
  options = {
    nix = {
      nixpkgs = {
        allowUnfree = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "Allow unfree packages to be installed";
        };
      };
      experimental-features = {
        options = lib.mkOption {
          type = lib.types.listOf lib.types.string;
          default = [];
          description = "List of experimental features to enable";
        };
      };
    };
  };

  config = {
    nix = {
      nixpkgs = {
        nixpkgs.config.allowUnfree = cfg.nixpkgs.allowUnfree;
      };
      experimental-features = {
        nix.settings.experimental-features = cfg.experimental-features.options;
      };
    };
  };
}