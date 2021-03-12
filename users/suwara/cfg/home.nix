{ config, pkgs, ... }:

let
  secrets = import ../../../secrets/secrets.nix {};
in
{
  home-manager.users.suwara = {
    home.packages = with pkgs; [
      #Work
      git-crypt
      docker
      docker-compose
      kubectl
      git
      bazel
      kubernetes-helm

      #Sys
      jq
      binutils
      gcc
      openssl
      wget
      vim
      curl
      psmisc

      #Btyfy
      termite
      zsh
      oh-my-zsh
      polybar

      #Utilities
      firefox
      vscode
      pwgen
      openvpn
    ];
    home.file = {
      ".config" = {
        source = ./dotfiles/.config;
        recursive = true;
      };
      ".dmenurc".source = ./dotfiles/.dmenurc;
      ".extend.Xresources".source = ./dotfiles/.extend.Xresources;
      ".Xresources".source = ./dotfiles/.Xresources;
    };
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
    programs.zsh = {
      enable = true;
      enableAutosuggestions = true;

      shellAliases = {
        rebuild-nix = "sudo nixos-rebuild -I nixos-config=/home/suwara/_GIT/nixos/configuration.nix switch";
        nix-search = "nix-env -qaP";
      };

      oh-my-zsh = {
        enable = true;
        plugins = [];
        theme = "agnoster";
      };
    };
  };
}
