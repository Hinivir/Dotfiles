{ config, pkgs, lib, inputs, ... }: {
  system.stateVersion = "24.05";
  nixpkgs.hostPlatform.system = "x86_64-linux";
  wsl.wslConf.network.hostname = "OmikamiWSL";
  wsl.enable = true;
  wsl.defaultUser = "viktor";
  wsl.startMenuLaunchers = true;
  nix.settings = { experimental-features = [ "flakes" "nix-command" ]; };
  programs = { nix-ld.enable = true; };
  environment.systemPackages = with pkgs; [
    vim
    wget
    direnv
    git
    inputs.my-nvim.packages.${system}.default
    inputs.jerry.packages.${system}.default
    inputs.lobster.packages.${system}.default
    mpv
    vlc
    tmux
  ];
}
