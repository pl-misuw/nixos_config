{ config, pkgs, ... }:

#
# Notes about installation
# ---
# 1. Remove dockerd before using this config 
#   (Otherwise you are in for some connectivity issues)
# 2. chmod 0644 /var/lib/kubernetes/secrets/admin-key.pem
# 

let
  kubeMasterIP = "10.1.1.2";
  kubeMasterHostname = config.networking.hostName;
  kubeMasterAPIServerPort = 443;
in
{
  # resolve master hostname
  networking.extraHosts = "${kubeMasterIP} ${kubeMasterHostname}";

  # packages for administration tasks
  environment.systemPackages = with pkgs; [
    kompose
    kubectl
    kubernetes
  ];

  services.kubernetes = {
    roles = ["master" "node"];
    masterAddress = kubeMasterHostname;
    easyCerts = true;
    apiserver = {
      securePort = kubeMasterAPIServerPort;
      advertiseAddress = kubeMasterIP;
    };

    # use coredns
    addons.dns.enable = true;

    # needed if you use swap
    kubelet.extraOpts = "--fail-swap-on=false";
  };
}
