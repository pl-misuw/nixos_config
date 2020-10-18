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
  #Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  # Environment thingies
  environment.systemPackages = with pkgs; [
    exa
    fd
    ripgrep
  ];
  
    # List packages installed in system profile. To search, run:
  # $ nix search wget
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
  services.xserver = {
    enable = true;
    layout = "us";
    exportConfiguration = true;
    xkbOptions = "eurosign:e";
    desktopManager = {
      plasma5.enable = true;
      xterm.enable = false;
    };
    windowManager.i3 = {
      enable = true;
      configFile = "/.config/i3/config";
      package = pkgs.i3-gaps;
      extraPackages = with pkgs; [
        i3lock #default i3 screen locker
        i3status #if you are planning on using i3blocks over i3status
      ];
    };
  };

  # Enable xrdp
  services.xrdp.enable = true;
  #services.xrdp.defaultWindowManager = "${pkgs.i3-gaps}/bin/i3";
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
