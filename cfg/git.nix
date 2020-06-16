{ pkgs, ... }:

{
   programs.git = {
    package = pkgs.gitAndTools.gitFull;
    enable = true;
    userName = "Michal Suwara";
    userEmail = "suwara.michal@gmail.com";
    lfs.enable = true;
  };
}
