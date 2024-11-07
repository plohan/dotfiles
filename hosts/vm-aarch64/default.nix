{ config, pkgs, nixpkgs-unstable, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/system.nix
      ../../modules/docker.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable networking
  networking.hostName = "nixos";
  networking.firewall.allowedTCPPorts = [ 8888 8080 ];
  networking.networkmanager.enable = true;

  environment.systemPackages = with pkgs;
  let
    unstable = nixpkgs-unstable.legacyPackages.${pkgs.system};
  in [
    git
    neovim

    gcc
    patchelf
    pkg-config
    openssl

    dconf
  ];


  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
    # pinentryPackage = "curses";
    # enableSSHSupport = true;
  };

  hardware = {
    opengl.enable = true;

    nvidia.modesetting.enable = true;
  };

  system.stateVersion = "24.05";
}
