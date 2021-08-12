{ pkgs, lib, ... }:

{

  home-manager.users.suwara = {
  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;

    config = rec {
      modifier = "Mod4";
      bars = [ ];

      window.border = 0;

      gaps = {
        inner = 15;
        outer = 5;
      };

      keybindings = lib.mkOptionDefault {
        "XF86AudioMute" = "exec amixer set Master toggle";
        "XF86AudioLowerVolume" = "exec amixer set Master 4%-";
        "XF86AudioRaiseVolume" = "exec amixer set Master 4%+";
        "XF86MonBrightnessDown" = "exec brightnessctl set 4%-";
        "XF86MonBrightnessUp" = "exec brightnessctl set 4%+";
        "${modifier}+t" = "exec termite";
        "${modifier}+d" = "exec ${pkgs.rofi}/bin/rofi -modi drun -show drun";
        "${modifier}+v" = "exec code";
        "${modifier}+s" = "exec nix search --json | jq 'keys' | rofi -dmenu";
        "${modifier}+Shift+d" = "exec ${pkgs.rofi}/bin/rofi -show window";
        "${modifier}+b" = "exec firefox";
        "${modifier}+Shift+x" = "exec systemctl suspend";
      };

      startup = [
        {
          command = "exec xrandr --output eDP-1 --mode 2560x1440 --pos 0x720 --rotate normal --output DP-1 --primary --mode 3840x2160 --pos 2560x0 --rotate normal --output HDMI-1 --off --output DP-2 --off";
          always = true;
          notification = false;
        }
        {
          command = "exec i3-msg workspace 1";
          always = true;
          notification = false;
        }
        {
          command = "systemctl --user restart polybar.service && sleep 1";
          always = true;
          notification = false;
        }
        {
          command = "${pkgs.feh}/bin/feh --bg-scale ~/Pictures/background.jpg";
          always = true;
          notification = false;
        }
      ];
    };
  };
  };
}
