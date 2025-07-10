{ self, inputs, ... }:
{
  imports = [ inputs.easy-hosts.flakeModule ];

  config.easy-hosts = {
    additionalClasses = {
      wsl = "nixos";
    };

    perClass = class: {
      modules = [
        "${self}/modules/${class}/default.nix"
      ];
    };

    hosts = {
      Omikami = {};

      OmikamiWsl = {
        class = "wsl";
      };
    };
  };
}
