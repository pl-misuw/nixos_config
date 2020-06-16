{ config, pkgs, ... }:

let
  secrets = import ../../../secrets/secrets.nix {};
in
{
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
}