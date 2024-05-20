{
  input,
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.hyprland;
  inherit (import ./package.nix {inherit input pkgs;}) grimblast hyprshot hyprpicker;
in {
  options.hyprland = {
    enable = mkEnableOption "Enable Hyprland";
  };

  config = mkIf cfg.enable {
    imports = [
      ./package.nix
    ];
    home.packages = [
      hyprshot
      grimblast
      hyprpicker
      pkgs.rofi
      pkgs.wlogout
      pkgs.wl-clipboard
      pkgs.foot
      pkgs.spotify
      pkgs.vesktop
    ];
    wayland.windowManager.hyprland = {
      enable = true;
      package = input.hyprland.packages.hyprland;
      xwayland.enable = true;
      systemd = {
        enable = true;
        variables = ["--all"];
      };
      settings = {
        gestures = {
          workspace_swipe = true;
        };

        input = {
          kb_layout = "fr";
          follow_mouse = 1;
          touchpad.natural_scroll = "no";
        };

        dwindle = {
          pseudotile = false;
          preserve_split = "yes";
          no_gaps_when_only = false;
          special_scale_factor = 0.9; # restore old special workspace behaviour
        };

        misc = {
          enable_swallow = true;
          swallow_regex = "Alacritty|foot";
        };

        windowrulev2 = [
          # wlogout
          "fullscreen,class:wlogout"
          "fullscreen,title:wlogout"
          "noanim, title:wlogout"

          # spotify
          "tile, title:Spotify"
          "tile, class:^(Spotify)$"

          # firefox
          "idleinhibit fullscreen, class:^(firefox)$"
          "float,title:^(Firefox — Sharing Indicator)$"
          "move 0 0,title:^(Firefox — Sharing Indicator)$"
          "float, title:^(Picture-in-Picture)$"
          "pin, title:^(Picture-in-Picture)$"
        ];

        "$MOD" = "SUPER";
        "$MODSHIFT" = "SUPER+SHIFT";
        "$ALTSHIFT" = "ALT+SHIFT";

        bind = [
          "$MOD, Q, killactive"
          "$MOD, SUPR, wlogout -p layer-shell"
          "$MOD, F, fullscreen"
          "$MOD, V, tooglefloating"
          "$MOD, T, togglegroup"
          "$MODSHIFT, G, changegroupactive"
          "$MOD, P, pseudo"

          "$MOD, RETURN, alacritty"
          "$MOD, W, exec, firefox"
          "$MOD, R, exec, rofi -show drun"
          "$MODSHIFT, R, exec, anyrun"
          "$MOD, D, exec, dolphin"

          "$MODSHIFT, right, movetoworkspace,+1" # move focused window to the next ws
          "$MODSHIFT, left, movetoworkspace,-1" # move focused window to the previous ws
          "$MOD, mouse_down, workspace,e+1" # move to the next ws
          "$MOD, mouse_up, workspace,e-1" # move to the previous ws

          # focus controls
          "$MOD, left, movefocus, l" # move focus to the window on the left
          "$MOD, right, movefocus, r" # move focus to the window on the right
          "$MOD, up, movefocus, u" # move focus to the window above
          "$MOD, down, movefocus, d" # move focus to the window below

          # screenshot and receording binds
          ''$MODSHIFT, P, exec, grim - | wl-copy --type image/png && notify-send "Screenshot" "Screenshot copied to clipboard"; $enable''
          "$MODSHIFT, S, exec, hyprshot" # screenshot and then pipe it to swappy
          "$MOD, Print, exec, grimblast --notify --cursor copysave output" # copy all active outputs
          "$ALTSHIFT, S, exec, grimblast --notify --cursor copysave screen" # copy active screen
          "$ALTSHIFT, R, exec, grimblast --notify --cursor copysave area" # copy selection area

          "$MODSHIFT, B, exec, ags -t bar"

          # set workspace switch
          "$MOD, ampersand, workspace, 1"
          "$MOD, eacute, workspace, 2"
          "$MOD, quotedbl, workspace, 3"
          "$MOD, apostrophe, workspace, 4"
          "$MOD, parenleft, workspace, 5"
          "$MOD, minus, workspace, 6"
          "$MOD, egrave, workspace, 7"
          "$MOD, underscore, workspace, 8"
          "$MOD, ccedilla, workspace, 9"
          "$MOD, agrave, workspace, 10"

          "$MODSHIFT, ampersand, movetoworkspace, 1"
          "$MODSHIFT, eacute, movetoworkspace, 2"
          "$MODSHIFT, quotedbl, movetoworkspace, 3"
          "$MODSHIFT, apostrophe, movetoworkspace, 4"
          "$MODSHIFT, parenleft, movetoworkspace, 5"
          "$MODSHIFT, minus, movetoworkspace, 6"
          "$MODSHIFT, egrave, movetoworkspace, 7"
          "$MODSHIFT, underscore, movetoworkspace, 8"
          "$MODSHIFT, ccedilla, movetoworkspace, 9"
          "$MODSHIFT, agrave, movetoworkspace, 10"

          "$MOD, S, togglespecialworkspace"
          "$MODSHIFT, S, movetoworkspace, special"
        ];

        bindm = [
          "$MOD,mouse:272,movewindow"
          "$MOD,mouse:273,resizewindow"
        ];
        # binds that will be repeated, a.k.a can be held to toggle multiple times
        binde = [
          # volume controls
          ",XF86AudioRaiseVolume, exec, wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 6%+"
          ",XF86AudioLowerVolume, exec, wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 6%-"

          # brightness controls
          '',XF86MonBrightnessUp,exec,ags --run-js "brightness.screen += 0.05"''
          '',XF86MonBrightnessDown,exec, ags --run-js "brightness.screen -= 0.05"''
        ];

        # binds that are locked, a.k.a will activate even while an input inhibitor is active
        bindl = [
          # media controls
          ",XF86AudioPlay,exec,playerctl play-pause"
          ",XF86AudioPrev,exec,playerctl previous"
          ",XF86AudioNext,exec,playerctl next"

          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ];
      };

      exec-once = [
        "ags"
        "hyprctl setcursor ${pkgs.catppuccin-cursors.mochaDark} 15"
      ];

      extraConfig = ''
        monitor= DP-1,preferred, preferred,
      '';
    };
  };
}
