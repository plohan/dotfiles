{ inputs, pkgs, nixpkgs-unstable, lib, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = builtins.readFile ./hyprland.conf;
    systemd.variables = ["--all"];
  };

  home.file.".config/hypr/wallpapers" = {
    source = ./wallpapers;
    recursive = true;
  };

  home.file.".config/hypr/scripts" = {
    source = ./scripts;
    recursive = true;
  };

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 14;
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.flat-remix-gtk;
      name = "Flat-Remix-GTK-Grey-Darkest";
    };

    iconTheme = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
    };
  };

  home.packages = with pkgs; [
    brightnessctl

    swww
    wofi

    # xwaylandvideobridge
    networkmanagerapplet
  ];
}

