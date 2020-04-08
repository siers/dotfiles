rec {
  autoLogin = {
    lightdm = {
      enable = true;
      autoLogin.enable = true;
      autoLogin.user = "s";
    };
  };

  i3 = {
    xserver = {
      windowManager.default = "i3";
      windowManager.i3.enable = true;

      desktopManager.default = "none";
      displayManager = autoLogin;
    };
  };

  xfce-i3 = {
    xserver = {
      libinput.enable = false;

      windowManager.default = "i3";
      windowManager.i3.enable = true;

      desktopManager.default = "xfce";
      desktopManager.xfce.enable = true;
      desktopManager.xfce.noDesktop = true;

      displayManager = autoLogin;
    };
  };

  xfce-i3-backlight = {
    xserver = {
      windowManager.default = "i3";
      windowManager.i3.enable = true;

      desktopManager.default = "xfce";
      desktopManager.xfce.enable = true;
      desktopManager.xfce.noDesktop = true;

      displayManager = {
        lightdm = {
          enable = true;
          autoLogin.enable = true;
          autoLogin.user = "s";
        };
      };

      extraConfig = ''
          Section "Device"
            Identifier  "card0"
            Driver      "intel"
            Option      "Backlight"  "intel_backlight"
            BusID       "PCI:0:2:0"
          EndSection
      '';
    };
  };

  dm = dm: {
    xserver = {
      desktopManager.${dm}.enable = true;
      displayManager = autoLogin;
    };
  };

  # services = {
  #   xserver.enable = true;
  #   xserver.displayManager = {
  #     gdm = {
  #       enable = true;
  #       wayland = true;
  #     };
  #   };
  #   xserver.desktopManager = {
  #     gnome3.enable = true;
  #     default = "gnome3";
  #   };
  # };
}
