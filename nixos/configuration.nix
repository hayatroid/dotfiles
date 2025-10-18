{ config, lib, pkgs, ... }:

{
  wsl.enable = true;
  wsl.defaultUser = "hayatroid";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "25.05";

  virtualisation.docker.enable = true;
  users.users.hayatroid = {
    shell = pkgs.zsh;
    extraGroups = [
      "docker"
    ];
  };

  environment.systemPackages = with pkgs; [
    wget
  ];

  programs.zsh.enable = true;
  programs.nix-ld.enable = true;
}
