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

  intel-brightness-script = createCommandPackage "intel-brightness-script" ''
    #! /usr/bin/env bash
    echo "$1" > /sys/class/backlight/intel_backlight/brightness
  '';

  xclip-for-mac = haskellPackages.callPackage ./packages/xclip-for-mac.nix {};
}
