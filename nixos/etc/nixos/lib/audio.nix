{ config, pkgs, ... }:

let
  musnix = fetchTarball {
    url = "https://github.com/musnix/musnix/archive/master.tar.gz";
    sha256 = "1ybja7i5c8nh0drlp4pjxkp3v6zp7f8hi8d8nwbsgf2ym9cxjlwf";
  };
in {
  imports = [ musnix ];

  musnix.enable = true;

  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
    support32Bit = true;
    daemon.config = {
      flat-volumes = "no";
    };
  };

  environment.systemPackages = with pkgs; [
    ardour
    jack2Full
    qjackctl
    qsynth
  ];
}
