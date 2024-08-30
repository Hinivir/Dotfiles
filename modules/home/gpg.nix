{
  lib,
  config,
  ...
}: let
  cfg = config.gpg;
in {
  options.gpg = {
    enable = lib.mkEnableOption "Enable gpg";
  };

  config = {
    programs.gpg = {
      enable = true;
      homedir = "${config.xdg.dataHome}/gnugpg";
      settings = {
        #defalt-key = key;
        #trusted-key = key;
        keyserver = "https://keys.openpgp.org";
        personal-cipher-preferences = "AES256 AES192 AES";
        pesonal-digest-preferences = "SHA512 SHA384 SHA256";
        personal-compress-preferences = "ZLIB BZIP2 ZIP Uncompressed";
        default-preference-list = "SHA512 SHA384 SHA256 AES256 AES192 AES ZLIB BZIP2 ZIP Uncompressed";
        cert-digest-algo = "SHA512";
        s2k-digest-algo = "SHA512";
        s2k-cipher-algo = "AES256";
        charset = "utf-8";
        fixed-list-mode = "";
        no-comments = "";
        no-emit-version = "";
        no-greeting = "";
        keyid-format = "0xlong";
        list-options = "show-uid-validity";
        verify-options = "show-uid-validity";
        with-fingerprint = "";
        require-cross-certification = "";
        no-symkey-cache = "";
        use-agent = "";
        armor = "";
        throw-keyid = "";
      };

      scdaemonSettings.deny-admin = true;
    };
  };
}
