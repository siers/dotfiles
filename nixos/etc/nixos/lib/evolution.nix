{ config, pkgs, lib, ... }:

{
  environment.systemPackages = (import ../lib/package-sets.nix { inherit pkgs; }).everything ++
    (with pkgs; [
      (sbt.override { jre = openjdk11; })
      bloop

      teams
      jetbrains.idea-community

      dbeaver
      kafkacat
      openjdk11
      cassandra
    ]);
}
