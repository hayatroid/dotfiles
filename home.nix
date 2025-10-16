{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "hayatroid";
  home.homeDirectory = "/home/hayatroid";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    docker
    fzf
    gcc
    git
    htmlq
    jq
    openssl
    pkg-config
    vim
    wget

    nodejs

    rustup
    tombi

    go
    golangci-lint
  ];

  home.sessionVariables = {
    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
  };

  home.sessionPath = [
    "$HOME/.cargo/bin"
    "$HOME/.npm-global/bin"
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.starship.enable = true;
  programs.zoxide.enable = true;

  programs.zsh = {
    enable = true;

    zsh-abbr = {
      enable = true;
      abbreviations = {
        ns = "sudo nixos-rebuild switch";
        hs = "home-manager switch --flake ~/dotfiles";

        b = "cargo run --bin";
        t = "cargo atcoder test --release";
        s = "cargo atcoder submit --release";

        ga = "git add";
        gc = "git commit -m";
        gp = "git push";

        du = "docker compose up -d";
        dd = "docker compose down";
      };
    };

    antidote = {
      enable = true;
      plugins = [
        "hlissner/zsh-autopair"
        "zsh-users/zsh-autosuggestions"
        "zsh-users/zsh-syntax-highlighting"
      ];
    };
  };
}
