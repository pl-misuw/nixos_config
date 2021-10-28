{ config, pkgs, ... }:

let
  secrets = import ../../secrets/secrets.nix {};
in
{
  imports = [ 
    ./home.nix
    #../../modules/k8s.nix
    #../../modules/k8s_no_Gondek.nix
    #../../modules/docker.nix
  ];

  # Environment thingies
  environment.variables = {
    LC_ALL = "C";
  };

  environment.systemPackages = with pkgs; [
    exa
    fd
    ripgrep
  ];
  
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.sessionVariables.TERMINAL = [ "termite" ];

  # List services that you want to enable:
  hardware.pulseaudio.enable = true;
  programs.dconf.enable = true;
  # Enable pipewire
  # services.pipewire = {
  #   enable = true;
  #   alsa.enable = true;
  #   alsa.supporrt32Bit = true;
  #   pulse.enable = true;
  #   # If you want to use JACK applications, uncomment this
  #   #jack.enable = true;

  #   # use the example session manager (no others are packaged yet so this is enabled by default,
  #   # no need to redefine it in your config for now)
  #   media-session.enable = true;
  #   config.pipewire = {
  #     "context.properties" = {
  #     #"link.max-buffers" = 64;
  #     "link.max-buffers" = 16; # version < 3 clients can't handle more than this
  #     "log.level" = 2; # https://docs.pipewire.org/#Logging
  #     #"default.clock.rate" = 48000;
  #     #"default.clock.quantum" = 1024;
  #     #"default.clock.min-quantum" = 32;
  #     #"default.clock.max-quantum" = 8192;
  #     };
  #   };
  # };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.permitRootLogin = "no";

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ 3389 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

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
    shell = pkgs.zsh;
    createHome = true;
    useDefaultShell = false;
    hashedPassword = secrets.users.suwara.hashedPassword;
  };

  nix.trustedUsers = [ "root" "suwara" ];
}
