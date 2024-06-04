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
      noto-fonts-cjk
      noto-fonts-emoji
      fira-code
      fira
      ibm-plex
      jetbrains-mono
      fira-code-symbols
      powerline-fonts
      nerdfonts
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
  nixpkgs.config.allowUnfree = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.imsozrious = {
    isNormalUser = true;
    description = "Pannawich Lohanimit";
    extraGroups = [ "networkmanager" "wheel" "docker" "plugdev" ];
    packages = with pkgs; [
      firefox
      kate
      discord
      gh
    ];
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

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us,th";
    variant = ",";
    options = "grp:caps_toggle";
  };
}
