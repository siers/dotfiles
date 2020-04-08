{ config, pkgs, ... }:

{
  fonts = {
    fontconfig.enable = true;
    fonts = with pkgs; [
      dejavu_fonts
      liberation_ttf
      material-icons
      source-code-pro
      source-sans-pro

      emojione
      noto-fonts
      noto-fonts-emoji
    ];
  };
}
