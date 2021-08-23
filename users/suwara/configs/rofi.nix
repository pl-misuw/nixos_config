{ pkgs, ... }:

let
  rofiBlocks = pkgs.callPackage ./rofi-blocks { };
in

{

  home-manager.users.suwara = {
  programs.rofi = {
    enable = true;
    plugins = [ rofiBlocks ];

    theme = builtins.toString (pkgs.writeText "rofi-theme" ''
      /**
      * Copyright: deadguy
      * (edited by Litarvan and Th0rgal)
      */

        configuration {
          display-run: " ";
          display-drun: "  ";
          display-window: "  ";
          drun-display-format: "{icon} {name}";
          font: "JetBrainsMono Nerd Font Medium 10";
          modi: "window,run,drun,file-browser";
          show-icons: true;
        }

        * {
          polar-1: #2E3440;
          polar-2: #3B4252;
          polar-3: #434C5E;
          polar-4: #4C566A;

          snow-1: #D8DEE9;
          snow-2: #E5E9F0;
          snow-3: #ECEFF4;

          frost-1: #8FBCBB;
          frost-2: #88C0D0;
          frost-3: #81A1C1;
          frost-4: #5E81AC;

          aurora-1: #BF616A;
          aurora-2: #D08770;
          aurora-3: #EBCB8B;
          aurora-4: #A3BE8C;
          aurora-5: #B48EAD;

          background-color: @polar-1;
          
          border: 0;
          margin: 0;
          padding: 0;
          spacing: 0;
        }

        element {
          padding: 12;
          orientation: vertical;
          text-color: @frost-3;
        }

        element selected {
          text-color: @aurora-3;
        }

        entry {
          background-color: @polar-2;
          padding: 12 0 12 3;
          text-color: @frost-1;
        }

        inputbar {
          children: [prompt, entry];
        }

        listview {
          columns: 1;
          lines: 8;
          scrollbar: true;
        }

        mainbox {
          children: [inputbar, listview];
        }

        prompt {
          background-color: @polar-2;
          enabled: true;
          font: "FontAwesome 12";
          padding: 12 0 0 12;
          text-color: @frost-1;
        }

        window {
          transparency: "real";
        }
    '');
  };
  };
}
