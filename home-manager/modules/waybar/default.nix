{ inputs, pkgs, ...}:

{
  programs.waybar.enable = true;

  home.file.".config/waybar/config".text = builtins.readFile ./config;
  home.file.".config/waybar/styles.css".text = builtins.readFile ./styles.css;

  home.packages = with pkgs; [
    pavucontrol
  ];
}

