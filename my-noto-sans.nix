{ lib, stdenvNoCC, fetchzip }:

stdenvNoCC.mkDerivation rec {
  pname = "my-noto-sans";
  version = "2.004";
  src = fetchzip {
    url = "https://github.com/notofonts/noto-cjk/releases/download/Sans${version}/06_NotoSansCJKjp.zip";
    hash = "sha256-QoAXVSotR8fOLtGe87O2XHuz8nNQrTBlydo5QY/LMRo=";
    stripRoot = false;
  };
  installPhase = ''
    install -m444 -Dt $out/share/fonts/opentype/noto-cjk *.otf
  '';
}
