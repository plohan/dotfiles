{ config, pkgs, inputs, ... }:

{
  imports = [
    ./modules/neovim
    ./modules/hyprland-home-manager
    ./modules/waybar
    # ./modules/ags
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

