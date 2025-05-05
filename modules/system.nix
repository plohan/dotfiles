{ pkgs, ... }:

{
  # Set your time zone.
  time.timeZone = "Asia/Bangkok";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      fira-code
      fira
      ibm-plex
      jetbrains-mono
      fira-code-symbols
      powerline-fonts
    ];

    fontconfig = {
      defaultFonts = {
        serif = [ "Noto Sans Thai Looped" ];
        sansSerif = [ "Noto Sans Thai Looped" ];
        monospace = [ "Noto Sans Thai Looped" ];
      };
    };

    fontDir.enable = true;
  };

  # nix
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.substituters = [ "https://cache.nixos.org" "https://ghostty.cachix.org" ];
  nix.settings.trusted-public-keys = [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" "ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns=" ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnsupportedSystem = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.imsozrious = {
    isNormalUser = true;
    description = "Pannawich Lohanimit";
    extraGroups = [ "networkmanager" "wheel" "docker" "plugdev" ];
    initialPassword = "123456";
  };

  environment.systemPackages = [(
    pkgs.catppuccin-sddm.override {
      flavor = "mocha";
      font = "Noto Sans";
      fontSize = "9";
    }
  )];

  services.displayManager.sddm = {
    enable = true;

    theme = "catppuccin-mocha";
  };

  services.xserver.enable = true;

  #  Configure keymap in X11
  services.xserver.xkb = {
    layout = "us,th";
    variant = ",";
    options = "grp:caps_toggle";
  };
}
