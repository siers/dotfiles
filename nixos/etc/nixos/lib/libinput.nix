{ config, pkgs, ... }:

{
  environment = {
    etc."libinput-gestures.conf".text = ''
      gesture swipe left i3 workspace prev
      gesture swipe right i3 workspace next
    '';

    systemPackages = with pkgs; [
      libinput-gestures
    ];
  };

  services = {
    xserver = {
      synaptics.enable = false;

      libinput = {
        enable = true;
      };
    };
  };
}
