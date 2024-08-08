{ config, pkgs, inputs, ... }:

{
  imports = [
    ./modules/neovim
    ./modules/hyprland-home-manager
    ./modules/waybar
    ./modules/firefox.nix
    ./modules/zoxide.nix
  ];

  home.username = "imsozrious";
  home.homeDirectory = "/home/imsozrious";

  home.packages = with pkgs;
  let
    unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system};
  in
  [
    discord
    zip
    unzip
    neofetch

    unstable.cargo
    unstable.rustc
    unstable.rust-analyzer

    vscode

    openocd
    ripgrep
    kitty

    eza
    yq

    mtr

    lazygit
  ];

  programs.git = {
    enable = true;
    userName = "imsozrious";
    userEmail = "30285202+ImSoZRious@users.noreply.github.com";
    ignores = [
      ".direnv"
      ".envrc"
    ];
    extraConfig = {
      merge.tool = "vimdiff";
      init.defaultBranch = "main";
    };
  };

  programs.home-manager.enable = true;
  programs.direnv.enable = true;

  programs.bash.enable = true;

  programs.bash.shellAliases = {
    lg = "lazygit";
    v = "nvim";
    k = "kubectl";
    dc = "docker compose";
  };

  programs.bash.sessionVariables = {
    EDITOR = "nvim";
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.stateVersion = "24.05";
}

