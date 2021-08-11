{ config, pkgs, lib, ... }:

let
  secrets = import ../../secrets/secrets.nix {};
in
{
  imports = [
    ./configs/main.nix
  ];
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

      #Utilities
      firefox
      vscode
      pwgen
      openvpn
    ];
    home.sessionVariables = {
      NIXOS_CONFIG = /home/suwara/_GIT/nixos_config;
      EDITOR = "vim";
    };



    programs = {
      command-not-found.enable = true;

      git = {
        enable = true;
        userEmail = secrets.users.suwara.git.email;
        userName = "Michal Suwara";
        extraConfig = {
          core = {
          editor = "vim";
          };
        };
      };

      zsh = {
        enable = true;
        initExtraFirst = ''
          [ ! -d "$HOME/.zsh/fsh/" ] && mkdir $HOME/.zsh/fsh/
          export FAST_WORK_DIR=$HOME/.zsh/fsh/;
        '';
        plugins = [
          {
            name = "zsh-autosuggestions";
            src = pkgs.fetchFromGitHub {
              owner = "zsh-users";
              repo = "zsh-autosuggestions";
              rev = "v0.6.4";
              sha256 = "0h52p2waggzfshvy1wvhj4hf06fmzd44bv6j18k3l9rcx6aixzn6";
            };
          }
          {
            name = "fast-syntax-highlighting";
            src = pkgs.fetchFromGitHub {
              owner = "zdharma";
              repo = "fast-syntax-highlighting";
              rev = "v1.55";
              sha256 = "0h7f27gz586xxw7cc0wyiv3bx0x3qih2wwh05ad85bh2h834ar8d";
            };
          }
          {
            name = "powerlevel10k";
            src = pkgs.zsh-powerlevel10k;
            file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
          }
          {
            name = "powerlevel10k-config";
            src = lib.cleanSource ./configs/p10k-config;
            file = "p10k.zsh";
          }
        ];
      };
    };

    xsession.enable = true;

  };
}
