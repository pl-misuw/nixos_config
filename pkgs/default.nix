{ pkgs, lib, ... }:

with pkgs; rec {
  # Applications.
  rofi-blocks = callPackage ./rofi-blocks { };

}
