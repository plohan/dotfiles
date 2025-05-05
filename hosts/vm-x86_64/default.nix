{ config, pkgs, nixpkgs-unstable, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/system.nix
      ../../modules/docker.nix
      ../../modules/i3.nix
    ];

  virtualisation.vmware.guest.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable networking
  networking.hostName = "nixos";
  networking.firewall.enable = false;
  networking.networkmanager.enable = true;

  environment.systemPackages = with pkgs;
  let
    unstable = nixpkgs-unstable.legacyPackages.${pkgs.system};
  in [
    git

    gcc
    patchelf
    pkg-config
    openssl

    dconf

    xclip
  ];

  nixpkgs.config.allowUnSupportedSystem = true;

  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
    # pinentryPackage = "curses";
    # enableSSHSupport = true;
  };

  fileSystems."/host" = {
    fsType = "fuse./run/current-system/sw/bin/vmhgfs-fuse";
    device = ".host:/";
    options = [
      "umask=022"
      "uid=1000"
      "gid=1000"
      "allow_other"
      "auto_unmount"
      "defaults"
    ];
  };

  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "yes";
  services.openssh.settings.PasswordAuthentication = true;

  services.displayManager.sddm.enable = pkgs.lib.mkForce false;

  hardware = {
    graphics.enable = true;

    nvidia.modesetting.enable = true;
  };

  system.stateVersion = "24.05";
}
