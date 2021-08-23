{ pkgs, lib, ... }:

{

  home-manager.users.suwara = {

    # Immutable dotfiles
    home.file = {
      ".config" = {
        source = ./dotfiles;
        recursive = true;
      };
    };
  };
}