# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  secrets = import ./secrets/secrets.nix {};
  homeManager = fetchTarball https://github.com/nix-community/home-manager/archive/master.tar.gz;
in

{
  #####################
  # nix global config #
  #####################
  
  imports = [ # Include the results of the hardware scan.
    ''${homeManager}/nixos''
    ./hardware/lenovo-configuration.nix
    ./users/suwara/profile.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  networking.hostName = "workLifeBalance"; # Define your hostname.
  networking.wireless = {
    # enable = true;
    iwd.enable = true;
    interfaces = [ "wlp0s20f3" ];
    userControlled.enable = true;
    userControlled.group = "wheel";
  };
  networking.networkmanager = {
    enable = true;
    wifi.backend = "iwd";
  };

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  environment.variables = {
    LC_ALL = "C";
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "pl-PL.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "pl";
  };

  #Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    dpi = 110;

    desktopManager = {
      xterm.enable = false;
      xfce = {
       enable = true;
       noDesktop = true;
       enableXfwm = false;
      };
    };
  };


  # Set your time zone.
  time.timeZone = "Europe/Warsaw";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;
}
