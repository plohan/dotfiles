{ config, pkgs, nixpkgs-unstable, ... }:

{
  imports = [
    ../modules/bash.nix
    ../modules/kitty.nix
    ../modules/git.nix
    ../modules/neovim
  ];

  home.username = "imsozrious";
  home.homeDirectory = "/home/imsozrious";

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.stateVersion = "24.05";
}
