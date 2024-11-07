{ config, pkgs, nixpkgs-unstable, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/system.nix
      ../../modules/docker.nix
      ../../modules/i3.nix
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

    gcc
    patchelf
    pkg-config
    openssl

    dconf

    open-vm-tools
  ];

  systemd.services.vmware = {
    description = "VMWare Guest Service";
    wantedBy = [ "multi-user.target" ];
    after = [ "display-manager.service" ];
    unitConfig.ConditionVirtualization = "vmware";
    serviceConfig.ExecStart = "${pkgs.open-vm-tools}/bin/vmtoolsd";
  };

  systemd.mounts = [
    {
      description = "VMWare vmblock fuse mount";
      documentation = [ "https://github.com/vmware/open-vm-tools/blob/master/open-vm-tools/vmblock-fuse/design.txt" ];
      unitConfig.ConditionVirtualization = "vmware";
      what = "${pkgs.open-vm-tools}/bin/vmware-vmblock-fuse";
      where = "/run/vmblock-fuse";
      type = "fuse";
      options = "subtype=vmware-vmblock,default_permissions,allow_other";
      wantedBy = [ "multi-user.target" ];
    }
  ];

  nixpkgs.config.allowUnSupportedSystem = true;

  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
    # pinentryPackage = "curses";
    # enableSSHSupport = true;
  };

  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "yes";
  services.openssh.settings.PasswordAuthentication = true;

  hardware = {
    opengl.enable = true;

    nvidia.modesetting.enable = true;
  };

  system.stateVersion = "24.05";
}
