{ config, pkgs, ... }:
{
  services.xserver = {
    enable = true;

    desktopManager = {
      xterm.enable = false;
      wallpaper.mode = "fill";
    };

    displayManager = {
      lightdm.enable = true;
    };

    windowManager = {
      i3.enable = true;
    };
  };
  services.displayManager = {
    defaultSession = "none+i3";
  };
}
