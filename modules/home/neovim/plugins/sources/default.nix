{
  self,
  pkgs,
  ...
}: let
  inherit (pkgs) fetchFromGitHub;
  inherit (pkgs.vimUtils) buildVimPlugin;

  sources = {
    hmts = buildVimPlugin {
      name = "hmts.nvim";
      src = fetchFromGitHub {
        owner = "calops";
        repo = "hmts.nvim";
        rev = "ba1239972a1f56b94252d4f85a43e777ac419662";
        sha256 = "1n67k7kl2xz3zi75h1qb524nxlgvrgwr4ywsykqwz1k7dlkxh3ck";
      };
    };

    smart-splits = buildVimPlugin {
      name = "smart-splits";
      src = fetchFromGitHub {
        owner = "mrjones2014";
        repo = "smart-splits.nvim";
        rev = "f6fcb79527872e9330c554915af2ca511c388390";
        sha256 = "0js9l8siaf4hkfpzlzqj89a40xiv2h8wll3jlh4xndpnji6k2vy3";
      };
    };

    regexplainer = buildVimPlugin {
      name = "nvim-regexplainer";
      src = fetchFromGitHub {
        owner = "bennypowers";
        repo = "nvim-regexplainer";
        rev = "4250c8f3c1307876384e70eeedde5149249e154f";
        hash = "sha256-15DLbKtOgUPq4DcF71jFYu31faDn52k3P1x47GL3+b0=";
      };
    };

    specs-nvim = buildVimPlugin {
      name = "specs.nvim";
      src = fetchFromGitHub {
        owner = "edluffy";
        repo = "specs.nvim";
        rev = "2743e412bbe21c9d73954c403d01e8de7377890d";
        hash = "sha256-mYTzltCEKO8C7BJ3WrB/iFa1Qq1rgJlcjW6NYHPfmPk=";
      };
    };

    deferred-clipboard = buildVimPlugin {
      name = "deferred-clipboard";
      src = fetchFromGitHub {
        owner = "EtiamNullam";
        repo = "deferred-clipboard.nvim";
        rev = "810a29d166eaa41afc220cc7cd85eeaa3c43b37f";
        hash = "sha256-nanNQEtpjv0YKEkkrPmq/5FPxq+Yj/19cs0Gf7YgKjU=";
      };
    };

    data-viewer-nvim = buildVimPlugin {
      name = "data-viewer.nvim";
      src = fetchFromGitHub {
        owner = "VidocqH";
        repo = "data-viewer.nvim";
        rev = "40ddf37bb7ab6c04ff9e820812d1539afe691668";
        hash = "sha256-D5hvLhsYski11H9qiDDL2zlZMtYmbpHgpewiWR6C7rE=";
      };
    };

    vim-nftables = buildVimPlugin {
      name = "vim-nftables";
      src = fetchFromGitHub {
        owner = "awisse";
        repo = "vim-nftables";
        rev = "bc29309080b4c7e1888ffb1a830846be16e5b8e7";
        hash = "sha256-L1x3Hv95t/DBBrLtPBKrqaTbIPor/NhVuEHVIYo/OaA=";
      };
    };

    neotab-nvim = buildVimPlugin {
      name = "neotab.nvim";
      src = fetchFromGitHub {
        owner = "kawre";
        repo = "neotab.nvim";
        rev = "6c6107dddaa051504e433608f59eca606138269b";
        hash = "sha256-bSFKbjj8fJHdfBzYoQ9l3NU0GAYfdfCbESKbwdbLNSw=";
      };
    };
  };
in
  sources
