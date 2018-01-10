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
      windowManager.default = "i3";
      windowManager.i3.enable = true;

      desktopManager.default = "xfce";
      desktopManager.xfce.enable = true;
      desktopManager.xfce.noDesktop = true;

      displayManager = autoLogin;
    };
  };

  dm = dm: {
    xserver = {
      desktopManager.${dm}.enable = true;
      displayManager = autoLogin;
    };
  };
}
