{ config, pkgs, ... }:

{
  services = {
    printing = {
      enable = true;
      drivers = with pkgs; [
        gutenprint
        gutenprintBin
        hplip
        hplipWithPlugin
        samsungUnifiedLinuxDriver
        splix
        brlaser
      ];
    };
  };
}
