{ lib, stdenvNoCC, fetchzip }:

stdenvNoCC.mkDerivation rec {
  pname = "my-noto-serif";
  version = "2.003";
  src = fetchzip {
    url = "https://github.com/notofonts/noto-cjk/releases/download/Serif${version}/07_NotoSerifCJKjp.zip";
    hash = "sha256-dl+zA4qY1vb/sZ/fnVrRdaY8sqqHgedGJSLQXmJ3vfM=";
    stripRoot = false;
  };
  installPhase = ''
    install -m444 -Dt $out/share/fonts/opentype/noto-cjk OTF/Japanese/*.otf
  '';
}
