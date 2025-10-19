{ ... }:

let
  neko = builtins.readFile ./neko.txt;
in
{
  programs.zsh = {
    siteFunctions = {
      roremu = ''
        local n=''${1:-100}
        echo "${neko}" | sed -E "s/^(.{''$n}).*/\1/"
      '';
    };
  };
}
