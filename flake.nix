{
  description = "NixOS Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";

      inputs.nixpkgs.follows = "nixpkgs";
    };

    cellular-automaton = {
      url = "github:Eandrju/cellular-automaton.nvim";
      flake = false;
    };

    hyprland.url = "github:hyprwm/Hyprland";

    ags = {
      url = "github:Aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ghostty = {
      url = "github:ghostty-org/ghostty";
      inputs.nixpkgs-stable.follows = "nixpkgs";
      inputs.nixpkgs-unstable.follows = "nixpkgs-unstable";
    };

    challenger-deep = {
      url = "github:challenger-deep-theme/vim";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, nix-ld, ... }@inputs: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit nixpkgs-unstable home-manager; };
        modules = [
          ./hosts/ip

          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = ".bak";

            home-manager.users.imsozrious = import ./home-manager/home/ip.nix;

            home-manager.extraSpecialArgs = { inherit inputs; };
          }
        ];
      };
      vm-aarch64 = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        specialArgs = { inherit nixpkgs-unstable home-manager; };
        modules = [
          ./hosts/vm-aarch64

          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = ".bak";

            home-manager.users.imsozrious = import ./home-manager/home/vm-aarch64.nix;

            home-manager.extraSpecialArgs = { inherit inputs; };
          }
        ];
      };
      vm-x86_64 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit nixpkgs-unstable home-manager; };
        modules = [
          ./hosts/vm-x86_64

          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = ".bak";

            home-manager.users.imsozrious = import ./home-manager/home/vm-x86_64.nix;

            home-manager.extraSpecialArgs = { inherit inputs; };
          }
        ];
      };
      minimal-vm-x86_64 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit nixpkgs-unstable home-manager; };
        modules = [
          ./hosts/vm-x86_64

          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = ".bak";

            home-manager.users.imsozrious = import ./home-manager/home/minimal.nix;

            home-manager.extraSpecialArgs = { inherit inputs; };
          }
        ];
      };
    };

    templates = {
      nestPrisma = {
        path = ./templates/nestPrisma;
      };
    };
  };
}
