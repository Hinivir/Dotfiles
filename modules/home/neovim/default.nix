{
  config,
  inputs,
  lib,
  ...
}: let
  inherit (builtins) filter map toString elem;
  inherit (lib.filesystem) listFilesRecursive;
  inherit (lib.strings) hasSuffix;
  inherit (lib.lists) concatLists;
  cfg = config.neovim;

  mkNeovimModule = {
    path,
    ignoredPaths ? [./plugins/sources/default.nix],
  }:
    filter (hasSuffix ".nix") (
      map toString (
        filter (path: path != ./default.nix && !elem path ignoredPaths) (listFilesRecursive path)
      )
    );

  nvf = inputs.neovim-flake;
in {
  options.neovim = {
    enable = lib.mkEnableOption "Enable neovim";
  };

  config = lib.mkIf cfg.enable {
    imports = concatLists [
      # neovim-flake home-manager module
      [nvf.homeManagerModules.default]

      # construct this entire directory as a module
      # which means all default.nix files will be imported automatically
      (mkNeovimModule {path = ./.;})
    ];
  };
}
