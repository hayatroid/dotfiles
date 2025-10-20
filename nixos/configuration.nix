{ config, lib, pkgs, ... }:

{
  wsl.enable = true;
  wsl.defaultUser = "hayatroid";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "25.05";

  users.users.hayatroid = {
    shell = pkgs.zsh;
  };

  environment.systemPackages = with pkgs; [
    wget
  ];

  programs.zsh.enable = true;
  programs.nix-ld.enable = true;
}
