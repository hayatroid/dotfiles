{ config, pkgs, ... }:

{
  imports = [
    ./roremu
  ];

  nixpkgs.config.allowUnfree = true;

  home.username = "hayatroid";
  home.homeDirectory = "/home/hayatroid";
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    cz-cli
    delta
    docker
    dua
    eza
    fd
    fzf
    gcc
    git
    gitmoji-cli
    htmlq
    jq
    openssl
    pkg-config
    procs
    ripgrep
    vim
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

  programs.zsh = {
    enable = true;

    shellAliases = {
      ls = "eza --icons=auto --group-directories-first";
      pbcopy = "xclip -selection clipboard";
      pbpaste = "xclip -selection clipboard -out";
    };

    siteFunctions = {
      # ref: https://gist.github.com/ookam/c08096f78fe7ec64922f69cea7f485fc
      bouyomi = ''
        local bytes=$(echo -n "''$1" </dev/null | wc -c)
        local win_ip=$(ip route | grep default | cut -d' ' -f3)
        printf "\x01\x00\xff\xff\xff\xff\xff\xff\x00\x00\x00\x$(printf %02x ''$((bytes & 255)))\x$(printf %02x ''$((bytes >> 8)))\x00\x00''$1" | nc -w 2 ''${win_ip:-0.0.0.0} 50001
      '';
      akane = ''
        bouyomi "akane) ''$1"
      '';
      aoi = ''
        bouyomi "aoi) ''$1"
      '';
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
