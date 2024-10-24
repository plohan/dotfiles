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

  programs.hyprlock.enable = true;
  programs.hyprlock.settings = {
    general = {
      disable_loading_bar = true;
      grace = 15;
      hide_cursor = true;
      no_fade_in = false;
    };

    background = [
      {
        path = "screenshot";
        blur_passes = 3;
        blur_size = 8;
      }
    ];

    input-field = [
      {
        size = "200, 50";
        position = "0, -80";
        monitor = "";
        dots_center = true;
        fade_on_empty = false;
        font_color = "rgb(202, 211, 245)";
        inner_color = "rgb(91, 96, 120)";
        outer_color = "rgb(24, 25, 38)";
        outline_thickness = 5;
        placeholder_text = "'<span foreground=\"##cad3f5\">Password...</span>'";
        shadow_passes = 2;
      }
    ];
  };
  services.hypridle.enable = true;
  services.hypridle.settings = {
    general = {
      after_sleep_cmd = "hyprctl dispatch dpms on";
      ignore_dbus_inhibit = false;
      lock_cmd = "pidof hyprlock || hyprlock";
    };
  
    listener = [
      {
        timeout = 900;
        on-timeout = "pidof hyprlock || hyprlock";
      }
      {
        timeout = 1200;
        on-timeout = "hyprctl dispatch dpms off";
        on-resume = "hyprctl dispatch dpms on";
      }
    ];
  };

  home.packages = with pkgs; [
    brightnessctl

    swww
    wofi

    # xwaylandvideobridge
    networkmanagerapplet
  ];
}

