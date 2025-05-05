{ pkgs, ... }:
{
  home.packages = with pkgs; [
    zip
    unzip
    fastfetch

    lazygit
    parted
  ];
}

