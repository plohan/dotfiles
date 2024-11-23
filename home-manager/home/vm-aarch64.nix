{ config, pkgs, inputs, ... }:
{
  imports = [
    ../modules/git.nix
    ../modules/kitty.nix
    ../modules/bash.nix
    ../modules/common-tool.nix
    ../modules/neovim
    ../modules/vscode.nix
    ../modules/firefox.nix
    ../modules/zoxide.nix
  ];

  home.username = "imsozrious";
  home.homeDirectory = "/home/imsozrious";

  home.packages = with pkgs;
  let
    unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system};
  in
  [
    obs-studio

    unstable.cargo
    unstable.rustc
    unstable.rust-analyzer

    openocd
    ripgrep

    eza
    yq

    mtr

    typst
  ];

  programs.home-manager.enable = true;
  programs.direnv.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.stateVersion = "24.05";
}

