
{ config, pkgs, ... }:

{
  ## CUPS for printer
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.epson_201207w pkgs.epson-escpr2 pkgs.epson-escpr ];
  services.avahi.enable = true;
  services.avahi.publish.enable = true;
  services.avahi.publish.userServices = true;
  services.printing.listenAddresses = [ "*:631" ]; 
  services.printing.browsing = true;
  services.printing.defaultShared = true; # If you want


  ## SANE for scanner
  hardware.sane.enable = true;
  hardware.sane.extraBackends = [ pkgs.utsushi ];
  hardware.sane.netConf = "bjnp://192.168.1.5";
  #NETWORK SCANNER
  services.saned.enable = true;
  services.saned.extraConfig = "
  [Socket]
  ListenStream=6566
  Accept=yes
  MaxConnections=1
  192.168.1.5
  ## Access list
  192.168.1.0/24
  connect_timeout = 60
  ";
  services.udev.packages = [ pkgs.utsushi ];
  services.avahi.nssmdns = true;
  services.avahi.reflector = true;
}