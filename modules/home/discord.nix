{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.discord;
in {
  options.discord = {
    enable = lib.mkEnableOption "Enable discord";
  };

  config = lib.mkIf cfg.enable {
    programs.nixcord = {
      enable = true;
      config = {
        useQuickCss = true; # use out quickCSS
        themeLinks = [
          # or use an online theme
          "https://raw.githubusercontent.com/deceptionfalls/oxocarbon-discord/main/oxocarbondiscord.theme.css"
        ];
        frameless = true; # set some Vencord options
        plugins = {
          betterSessions.enable = true;
          betterSettings.enable = true;
          callTimer.enable = true;
          experiments.enable = true;
          fakeNitro.enable = true;
          favoriteEmojiFirst.enable = true;
          favoriteGifSearch.enable = true;
          fixSpotifyEmbeds.enable = true;
          fixYoutubeEmbeds.enable = true;
          forceOwnerCrown.enable = true;
          friendsSince.enable = true;
          gameActivityToggle.enable = true;
          imageZoom.enable = true;
          memberCount.enable = true;
          moreCommands.enable = true;
          moreKaomoji.enable = true;
          moreUserTags.enable = true;
          mutualGroupDMs.enable = true;
          openInApp.enable = true;
          pictureInPicture.enable = true;
          pinDMs.enable = true;
          platformIndicators.enable = true;
          roleColorEverywhere.enable = true;
          sendTimestamps.enable = true;
          silentMessageToggle.enable = true;
          silentTyping.enable = true;
          spotifyControls.enable = true;
          typingIndicator.enable = true;
        };
      };
    };
  };
}
