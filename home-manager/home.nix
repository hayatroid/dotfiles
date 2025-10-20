{ config, pkgs, nix-snapshotter, ... }:

{
  imports = [
    ./bouyomi
    nix-snapshotter.homeModules.default
  ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [ nix-snapshotter.overlays.default ];

  virtualisation.containerd.rootless = {
    enable = true;
    nixSnapshotterIntegration = true;
  };
  services.buildkit.rootless.enable = true;
  services.nix-snapshotter.rootless.enable = true;

  home.username = "hayatroid";
  home.homeDirectory = "/home/hayatroid";
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    cz-cli
    delta
    dua
    eza
    fd
    fzf
    gcc
    git
    gitmoji-cli
    htmlq
    jq
    nerdctl
    openssl
    pkg-config
    procs
    ripgrep
    xclip
    xh

    nodejs

    rustup
    tombi

    go
    golangci-lint

    typst
    (noto-fonts-cjk-sans.override { static = true; })
    (noto-fonts-cjk-serif.override { static = true; })
  ];

  fonts.fontconfig.enable = true;

  home.sessionVariables = {
    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
  };

  home.sessionPath = [
    "$HOME/.cargo/bin"
    "$HOME/.npm-global/bin"
  ];

  programs.home-manager.enable = true;

  programs.starship.enable = true;
  programs.zoxide.enable = true;

  programs.vim = {
    enable = true;

    extraConfig = ''
      set clipboard=unnamedplus
    '';
  };

  programs.zsh = {
    enable = true;

    shellAliases = {
      ls = "eza --icons=auto --group-directories-first";
      tree = "eza --icons=auto --group-directories-first --tree";

      pbcopy = "xclip -selection clipboard";
      pbpaste = "xclip -selection clipboard -out";
    };

    zsh-abbr = {
      enable = true;
      abbreviations = {
        ns = "sudo nixos-rebuild switch --flake ~/dotfiles#hayatroid";
        hs = "home-manager switch --flake ~/dotfiles#hayatroid";

        c = "code .";

        b = "cargo run --bin";
        t = "cargo atcoder test --release";
        s = "cargo atcoder submit --release";

        ga = "git add";
        gc = "git commit --message";
        gp = "git push";

        nu = "nerdctl compose up --detach";
        nd = "nerdctl compose down";
      };
    };

    antidote = {
      enable = true;
      plugins = [
        "hayatroid/zsh-roremu"
        "hlissner/zsh-autopair"
        "reegnz/jq-zsh-plugin"
        "zsh-users/zsh-autosuggestions"
        "zsh-users/zsh-syntax-highlighting"
      ];
    };
  };

  programs.bat = {
    enable = true;
    extraPackages = [ pkgs.bat-extras.core ];
    config.theme = "GitHub";
  };
}
