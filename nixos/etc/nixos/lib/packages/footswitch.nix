{ stdenv, pkgconfig, hidapi , fetchFromGitHub }:

stdenv.mkDerivation {
  name = "footswitch";
  src = fetchFromGitHub {
    owner = "rgerganov";
    repo = "footswitch";
    rev = "7b89a3b";
    sha256 = "07kalv16m1zwzzvdz4rdk96bbsqdgdlmlb08jxaph89p7m7r04xq";
  };
  nativeBuildInputs = [ pkgconfig ];
  buildInputs = [ hidapi ];
  PREFIX = "$out";

  installPhase = ''
    mkdir -p $out/bin
    cp footswitch scythe $out/bin
  '';
}
