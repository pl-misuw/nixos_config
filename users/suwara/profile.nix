{ config, pkgs, ... }:

let
  secrets = import ../../secrets/secrets.nix {};
in
{
  imports = [ 
    ./cfg/home.nix
    #../../modules/k8s.nix
    ../../modules/printer.nix
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
  services.openssh.passwordAuthentication = false;

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
    # displayManager = {
    #   sessionCommands = "i3status &";
    # };
    desktopManager = {
      plasma5.enable = true;
      xterm.enable = false;
    };
    windowManager.i3 = {
      enable = true;
      configFile = "/.config/i3/config";
      package = pkgs.i3-gaps;
      extraPackages = with pkgs; [
        dmenu
        i3lock #default i3 screen locker
        i3status #if you are planning on using i3blocks over i3status
      ];
    };
  };

  # Enable xrdp
  services.xrdp.enable = true;
  # services.xrdp.defaultWindowManager = "${pkgs.i3-gaps}/bin/i3";
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
      #SCANER
      "scanner"
      "lp" 
    ];
    home = "/home/suwara";
    shell = pkgs.zsh;
    createHome = true;
    useDefaultShell = true;
    #password = secrets.users.suwara.password;
    hashedPassword = secrets.users.suwara.hashedPassword;
    openssh.authorizedKeys.keys = [ 
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCeL8038PUD66LphFtTU+Pz228dnTth8QUoKez3IgZJfkeLYvAol2xCPYf7tTqkjukOybZ0iwEQiUtbbXUGslw8IJTETdACn5kQt1tp0OFmjcChw0/8I4A7tyfrp3KBUZHy0PrJ+hy7udVxhwZvwlJGcYJjtbSrJ+KI77rEG2lq//GCrtQJe4NsJHF46thUjOkYEMW5M7048C4wmrskPpcjumwYWAYClT37uMKuaN1eiHrT2F2f2AVL5dKFqcGHpKVSL1MdqG1gIwujKcmX83uORFjIXZVkoK/50vJ99zsRwi/YLn+R6Ig9IbXck8gfSRXRfSitWjg96rqQagfZBqZGZ5+e6lFnZw5Jx9egfrl0qwuKdGghutLXDDoVzNQcBR/n2dCes2kGYTR3dzpOiSs/rqTDmTDa33CFhtxPxiOBAb7BgutpkGDzlQLwkFVdhF0YVwu2IyktWobZ4Rka4QI5Fq8z2xp097/6Fze8Ep+hRVq0Ya78rk635ZS9b49beBU= michal.suwara@POL-MBP-MichalSuwara
      ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC33yZJp+I8lru+1HqF43cHIFAEmAKUj3rzSbMA3mNMq484/p7eX0FA8om7vQ6zSYApHyjP2eUwYJGG6OsYAx89jArcVyVKH+iVuZd9VAp4n3SMeHAvAsLUp33rGvGfyhfmF4UlEtRtHQZ0sPhB/FzEm4VIT0Z/o6OsblVh9tKxbm2g6ArlNnSgqbGaXhHzZSG2+pMHVcAv67KSLnSAwQ9DfpAeQ3uM8l9PfiWf5t6Qr6+3dPXwiqCtnqbciwiuo2yjjHl/tXzRJjSKPFA4cp7THA28HLCWICd+AzGScockhgHHv+sC/7txcPx6zKSF/E8xzlYn3ZpJEQECRzDeTaij admin@DESKTOP-2QC8DTR
      ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCtf5V1sC/y9wvPIGV4q9SxDp+pXO22h/kK8i8kMmOBK6ICdYotTtQpN3ANK8jUebkHrJM/EkqoEssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC33yZJp+I8lru+1HqF43cHIFAEmAKUj3rzSbMA3mNMq484/p7eX0FA8om7vQ6zSYApHyjP2eUwYJGG6OsYAx89jArcVyVKH+iVuZd9VAp4n3SMeHAvAsLUp33rGvGfyhfmF4UlEtRtHQZ0sPhB/FzEm4VIT0Z/o6OsblVh9tKxbm2g6ArlNnSgqbGaXhHzZSG2+pMHVcAv67KSLnSAwQ9DfpAeQ3uM8l9PfiWf5t6Qr6+3dPXwiqCtnqbciwiuo2yjjHl/tXzRJjSKPFA4cp7THA28HLCWICd+AzGScockhgHHv+sC/7txcPx6zKSF/E8xzlYn3ZpJEQECRzDeTaij admin@DESKTOP-2QC8DTR
      ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDEKRqz9DFK0MTzsooVofcyizpLvGZgWxZ3R02AR20eubiKMIWXksxj6ek4014vb2sNnkByb1UYli43bt+3A0AxYOBG6sayJ1vw9nI1fSw/uVdTIVhol+i9P6ioaxhjmC6xsPPh3UElDajqHUXcx3ocFiwikggvg2z+oShm1muwhOAtFVCMpbQ4IsHOj9f3fk2G8erudCYEpyhoOqbOGSWFJX9ecM4aP69YTlBbqL1SJBrnqYwt5LJCysAeUKd/0xVKCavQh9Jn7pFTtfUQOUEj8m/0tcn+m/vGWV8QhWMJNeX/ebaHI4KxDUYOvQq6xvd2hDmVNPcEumzs80JpqBz9 qwerty@qwerty
      ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICyQGWi0QWR+yqtwZ+S25Vun5QSM4no/YmzXPjqDpp5J r2r@MacBook-Pro.localdomain"
      ];
  };
  nix.trustedUsers = [ "root" "suwara" ];
}
