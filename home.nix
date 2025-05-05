{ config, pkgs, inputs, ... }:

{
  imports = [
    ./modules/neovim
    #./modules/hyprland-home-manager
    #./modules/waybar
    ./modules/vscode.nix
    #./modules/ags
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
    zip
    unzip
    fastfetch
    obs-studio

    unstable.cargo
    unstable.rustc
    unstable.rust-analyzer

    openocd
    ripgrep
    kitty

    eza
    yq

    mtr

    lazygit
    typst
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
      url = {
        "ssh://git@github.com" = {
          insteadOf = "https://github.com";
        };
      };
      user.signingkey = "5ACE2C4FBD9AD588";
    };
  };

  programs.home-manager.enable = true;
  programs.direnv.enable = true;
  programs.direnv.enableBashIntegration = true;
  programs.direnv.nix-direnv.enable = true;

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

