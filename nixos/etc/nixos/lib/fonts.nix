{ config, pkgs, ... }:

{
  fonts = {
    fontconfig.enable = true;
    fonts = with pkgs; [
      liberation_ttf
      corefonts
      ubuntu_font_family

      dejavu_fonts
      source-code-pro
      source-sans-pro

      emojione
      noto-fonts
      noto-fonts-emoji
      material-icons
    ];
  };
}
