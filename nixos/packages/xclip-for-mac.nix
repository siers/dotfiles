{ mkDerivation, base, bytestring, process, stdenv, fetchgit, lib }:
mkDerivation {
  pname = "xclip";
  version = "0.1.0.0";
  src = fetchgit {
    rev = "59f3d3bdc01df6be666e5d5cd9f95fa3d4443c9d";
    url = "https://github.com/siers/xclip-for-mac";
    sha256 = "0fbbi1zapla8b0ybllwsz1akb6aldqggjb0m5a54qmsbx4sbynvr";
  };
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [ base bytestring process ];
  description = "xclip for mac";
  license = "unlicense";
  platforms = lib.platforms.darwin;
}
