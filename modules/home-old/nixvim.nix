{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    inputs.my-nvim.packages.${system}.default
    lazygit
    stylua
    sumneko-lua-language-server
    ripgrep
  ];
}
