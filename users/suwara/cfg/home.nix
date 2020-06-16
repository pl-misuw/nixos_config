{ config, pkgs, ... }:

let
  secrets = import ../../../secrets/secrets.nix {};
in
{
  home-manager.users.suwara = {
    home.packages = with pkgs; [
      git-crypt
      kubectl
      jq
      binutils
      gcc
      openssl
      wget
      vim
      curl
      termite
      git
      zsh
    ];
    home.sessionVariables = {
      NIXOS_CONFIG = /home/suwara/projects/nixos-config;
      EDITOR = "vim";
    };
    programs.git = {
        enable = true;
        userEmail = secrets.users.suwara.git.email;
        userName = "Michal Suwara";
        extraConfig = {
            core = {
            editor = "vim";
            };
        };
    };
  };
}