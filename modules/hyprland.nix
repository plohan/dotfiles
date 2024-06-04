{ pkgs, nixpkgs-unstable, lib, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.systemPackages = with pkgs;
  let
    unstable = nixpkgs-unstable.legacyPackages.${pkgs.system};
  in [
    brightnessctl
    unstable.swww
    waybar
    wofi
    xwaylandvideobridge
    networkmanagerapplet

    hyprlock
    hypridle
  ];
}
