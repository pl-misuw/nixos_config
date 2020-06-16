{ config, pkgs, ... }:

let
  secrets = import ../../secrets/secrets.nix {};
in
{
  environment.systemPackages = with pkgs; [
    exa
    fd
    ripgrep
  ];

  users.users.suwara = {
    description = "Michal Suwara";
    uid = 6666;
    isNormalUser = true;
    group = "nogroup";
    extraGroups = [
      "wheel"
      "docker"
    ];
    home = "/home/suwara";
    shell = pkgs.bash;
    createHome = true;
    useDefaultShell = false;
    hashedPassword = secrets.users.suwara.hashedPassword;
  };

  home-manager.users.suwara = {
    home.packages = with pkgs; [
      git-crypt
      kubectl
      jq
      binutils
      gcc
      gnumake
      openssl
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

  nix.trustedUsers = [ "root" "suwara" ];
}
