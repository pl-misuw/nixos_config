{ pkgs, ... }:

{
  home-manager.users.suwara = {
    programs.termite = {
      enable = true;
      font = "JetbrainsMono Nerd Font 16px";
      backgroundColor = "rgba(0, 0, 0, 0.4)";
      foregroundColor = "rgba(235, 235, 235, 0.4)";
    };
  };
}
