{ config, pkgs, ... }:

let
  secrets = import ../../secrets/secrets.nix {};
in
{
  imports = [ 
    ./cfg/home.nix
    ../../modules/k8s.nix
    #../../modules/k8s_no_Gondek.nix
    #../../modules/docker.nix
  ];

  # Environment thingies
  environment.systemPackages = with pkgs; [
    exa
    fd
    ripgrep
  ];
  
    # List packages installed in system profile. To search, run:
    # $ nix search wget
    #Set unfree packages to be allowed
    nixpkgs.config.allowUnfree = true;

    #Set default terminal to termite
  environment.sessionVariables.TERMINAL = [ "termite" ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.permitRootLogin = "no";

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ 3389 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
   networking.firewall.enable = false;

  # Enable the X11 windowing system.
   services.xserver.enable = true;
   services.xserver.layout = "pl";
   services.xserver.windowManager.i3 = {
     enable = true;
     package = pkgs.i3;
     extraPackages = with pkgs; [
       dmenu
       i3status-rust
       i3lock-fancy
       i3blocks
       rofi
       polybar
     ];
   };
   services.xserver.xkbOptions = "eurosign:e";

  # Enable xrdp
  services.xrdp.enable = true;
  services.xrdp.defaultWindowManager = "${pkgs.icewm}/bin/icewm";
  
  # Define a user account. Don't forget to set a password with ‘passwd’.
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

  nix.trustedUsers = [ "root" "suwara" ];
}
