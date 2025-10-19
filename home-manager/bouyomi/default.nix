{ ... }:

let
  neko = builtins.readFile ./neko.txt;
in
{
  programs.zsh = {
    siteFunctions = {
      # ref: https://gist.github.com/ookam/c08096f78fe7ec64922f69cea7f485fc
      bouyomi = ''
        local input
        if [ -n "''$1" ]; then
          input="''$1"
        else
          input=$(cat)
        fi
        local bytes=$(echo -n "''$input" </dev/null | wc -c)
        local win_ip=$(ip route | grep default | cut -d' ' -f3)
        printf "\x01\x00\xff\xff\xff\xff\xff\xff\x00\x00\x00\x$(printf %02x ''$((bytes & 255)))\x$(printf %02x ''$((bytes >> 8)))\x00\x00''$input" | nc -w 2 ''${win_ip:-0.0.0.0} 50001
      '';

      akane = ''
        local input
        if [ -n "''$1" ]; then
          input="''$1"
        else
          input=$(cat)
        fi
        bouyomi "akane) ''$input"
      '';

      aoi = ''
        local input
        if [ -n "''$1" ]; then
          input="''$1"
        else
          input=$(cat)
        fi
        bouyomi "aoi) ''$input"
      '';
    };
  };
}
