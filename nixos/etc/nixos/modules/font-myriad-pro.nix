# https://gist.github.com/emmanuelrosa/a6f0e2f3bc80de2ffb51e6e9b73ebfcd

{ lib, stdenv, fetchurl }:

let
  fetchfont = name: num: sha:
    fetchurl {
      url = "https://fontsup.com/download/${builtins.toString num}.html";
      sha256 = sha;
      name = "${name}";
    };
in stdenv.mkDerivation rec {
  name = "myriad-pro-fonts-${version}";
  version = "2018-06-14";

  srcs = [
    (fetchfont "myriad-pro" 75044 "f2222a61c688389f855676216a791d548e2918dc17f1b4f2cb39bdf424a0820e")
    (fetchfont "myriad-pro-semibold-condensed" 75033 "130jams1pl45s3b1xwdy0r0p1fyf1ajnp16kfw4lb751vxq067z1")
    (fetchfont "myriad-pro-light" 75031 "0dkrp1dyhk8prapxqpwsg45snmki8jn6cbwsz1qw1nbz7s2xl56f")
    (fetchfont "myriad-pro-bold" 75020 "0kwkkrhjch85fx9lg5rzbnr1na386f0i3rh1lmc4g85f2y1hk1vn")
    (fetchfont "myriad-pro-light-semi-extended" 75030 "0bcx74yr88ifzxzgaba0g948d9c2smpns0kn8q1hxphlhp2ay3jf")
    (fetchfont "myriad-pro-semibold" 75039 "1cpwhkrs4m1wzsyivnyvjbw4wgd2r7myh82in6mdzdcn9yls5nf1")
    (fetchfont "myriad-pro-semibold-italic" 75034 "11nvlhhsdrazfnpsxgi92rl4jn1rhnk0xmpvl9f5gm4dsid0sbgn")
    (fetchfont "myriad-pro-semi-condensed" 75041 "0kffn6qp1amf05kjwm35hh1r18q9ir4d68cqfkrfa824zxpfvs1k")
  ];

  phases = [ "installPhase" ];

  installPhase = ''
    dest=$out/share/fonts/truetype
    mkdir -p $dest
    for font in $srcs
    do
        ln -s $font $dest/$(basename $font)
    done
  '';

  meta = with lib; {
    homepage = https://fontsup.com/font/myriad-pro.html;
    description = "Myriad Pro Adobe font";
    license = with licenses; [ unfree ];
    platforms = platforms.all;
    hydraPlatforms = [];
    maintainers = with maintainers; [ emmanuelrosa ];
  };
}
