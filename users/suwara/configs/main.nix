{ config, ... }:

{
  imports = [
    # ./compton.nix
    ./i3.nix
    ./polybar.nix
    # ./redshift.nix
    ./rofi.nix
    ./vscode.nix
  ];
}
