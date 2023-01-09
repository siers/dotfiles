pkgs:

with pkgs;

let
  createCommandPackage = name: script: runCommand name { inherit script; } ''
    mkdir -p $out/bin
    install -m755 <(echo "$script") "$out/bin/${name}"
  '';
in {
  alias = inputs: command: alias: runCommand "command-aliases" { buildInputs = inputs; } ''
    set -e
    mkdir -p $out/bin
    where="$(command -v ${command})"
    ln -s "$where" "$out/bin/${alias}"
  '';

  sym-alias = command: alias: runCommand "command-aliases" {} ''
    set -e
    mkdir -p $out/bin
    echo -e '#! /usr/bin/env sh\n"${command}" "$@"' > "$out/bin/${alias}"
  '';

  xclip-for-mac = haskellPackages.callPackage ./xclip-for-mac.nix {};

  footswitch = callPackage ./footswitch.nix {};
  rofimoji = callPackage ./rofimoji.nix {};
}
