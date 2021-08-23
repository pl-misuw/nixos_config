{ config, ... }:

{
  imports = [
    ./dotfiles.nix
    ./alacritty.nix
    ./termite.nix
    ./compton.nix
    ./i3.nix
    ./polybar.nix
    # ./redshift.nix
    ./rofi.nix
    ./vscode.nix
  ];
}
