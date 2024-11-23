{ config, pkgs, nixpkgs-unstable, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/system.nix
      ../../modules/docker.nix
      ../../modules/hyprland.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable networking
  networking.hostName = "nixos";
  networking.firewall.allowedTCPPorts = [ 8888 8080 ];
  networking.networkmanager.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.upower.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs;
  let
    unstable = nixpkgs-unstable.legacyPackages.${pkgs.system};
  in [
    git
    neovim

    grim
    slurp
    swappy

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

  services.udev.extraRules = ''
    # stm32 discovery boards, with onboard st/linkv1
    # ie, STM32VL.

    SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3744", \
        MODE="660", GROUP="plugdev", TAG+="uaccess", ENV{ID_MM_DEVICE_IGNORE}="1", \
        SYMLINK+="stlinkv1_%n"
    # stm32 nucleo boards, with onboard st/linkv2-1
    # ie, STM32F0, STM32F4.

    SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="374b", \
        MODE="660", GROUP="plugdev", TAG+="uaccess", ENV{ID_MM_DEVICE_IGNORE}="1", \
        SYMLINK+="stlinkv2-1_%n"

    SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3752", \
        MODE="660", GROUP="plugdev", TAG+="uaccess", ENV{ID_MM_DEVICE_IGNORE}="1", \
        SYMLINK+="stlinkv2-1_%n"

    # stm32 discovery boards, with onboard st/linkv2
    # ie, STM32L, STM32F4.

    SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3748", \
        MODE="660", GROUP="plugdev", TAG+="uaccess", ENV{ID_MM_DEVICE_IGNORE}="1", \
        SYMLINK+="stlinkv2_%n"
    # stlink-v3 boards (standalone and embedded) in usbloader mode and standard (debug) mode

    SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="374d", \
        MODE="660", GROUP="plugdev", TAG+="uaccess", ENV{ID_MM_DEVICE_IGNORE}="1", \
        SYMLINK+="stlinkv3loader_%n"

    SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="374e", \
        MODE="660", GROUP="plugdev", TAG+="uaccess", ENV{ID_MM_DEVICE_IGNORE}="1", \
        SYMLINK+="stlinkv3_%n"

    SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="374f", \
        MODE="660", GROUP="plugdev", TAG+="uaccess", ENV{ID_MM_DEVICE_IGNORE}="1", \
        SYMLINK+="stlinkv3_%n"

    SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3753", \
        MODE="660", GROUP="plugdev", TAG+="uaccess", ENV{ID_MM_DEVICE_IGNORE}="1", \
        SYMLINK+="stlinkv3_%n"

    SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3754", \
        MODE="660", GROUP="plugdev", TAG+="uaccess", ENV{ID_MM_DEVICE_IGNORE}="1", \
        SYMLINK+="stlinkv3_%n"

    SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3755", \
        MODE="660", GROUP="plugdev", TAG+="uaccess", ENV{ID_MM_DEVICE_IGNORE}="1", \
        SYMLINK+="stlinkv3loader_%n"

    SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3757", \
        MODE="660", GROUP="plugdev", TAG+="uaccess", ENV{ID_MM_DEVICE_IGNORE}="1", \
        SYMLINK+="stlinkv3_%n"

    # esp32 board
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6001", \
        MODE="660", GROUP="plugdev", TAG+="uaccess"

    # Digilent
    ATTRS{idVendor}=="1443", MODE:="666"
    ACTION=="add", ATTRS{idVendor}=="0403", ATTRS{manufacturer}=="Digilent", MODE:="666"

    ACTION=="add", ATTRS{idVendor}=="0403", ATTRS{manufacturer}=="Xilinx", MODE:="666"

    ATTR{idVendor}=="03fd", ATTR{idProduct}=="0008", MODE="666"
    ATTR{idVendor}=="03fd", ATTR{idProduct}=="0007", MODE="666"
    ATTR{idVendor}=="03fd", ATTR{idProduct}=="0009", MODE="666"
    ATTR{idVendor}=="03fd", ATTR{idProduct}=="000d", MODE="666"
    ATTR{idVendor}=="03fd", ATTR{idProduct}=="000f", MODE="666"
    ATTR{idVendor}=="03fd", ATTR{idProduct}=="0013", MODE="666"
    ATTR{idVendor}=="03fd", ATTR{idProduct}=="0015", MODE="666"
  '';
}
