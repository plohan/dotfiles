NIXADDR ?= 172.16.121.128
NIXUSER ?= imsozrious

MAKEFILE_DIR = $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
SSHOPTS = -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o PubkeyAuthentication=no

bootstrap1:
	ssh root@$(NIXADDR) $(SSHOPTS) " \
		parted /dev/sda -- mklabel gpt; \
		parted /dev/sda -- mkpart root ext4 512MB -8GB; \
		parted /dev/sda -- mkpart swap linux-swap -8GB 100%; \
		parted /dev/sda -- mkpart boot fat32 1MB 512MB; \
		parted /dev/sda -- set 3 esp on; \
		sleep 1; \
		mkfs.ext4 -L root /dev/sda1; \
		mkswap -L swap /dev/sda2; \
		mkfs.fat -F 32 -n boot /dev/sda3; \
		sleep 1; \
		swapon -L swap; \
		mount /dev/sda1 /mnt; \
		mkdir -p /mnt/boot; \
		mount /dev/sda3 /mnt/boot; \
		nixos-generate-config --root /mnt; \
		sed -i '/system\.stateVersion = .*/a \
			nix.extraOptions = \"experimental-features = nix-command flakes\";\n \
			services.openssh.enable = true;\n \
			services.openssh.settings.PasswordAuthentication = true;\n \
			services.openssh.settings.PermitRootLogin = \"yes\";\n \
			users.users.root.initialPassword = \"root\";\n \
		' /mnt/etc/nixos/configuration.nix; \
		nixos-install --no-root-password; \
	"

bootstrap2:
	rsync -av -e 'ssh $(SSHOPTS)' \
		--exclude='.git/' \
		--rsync-path='sudo rsync' \
		$(MAKEFILE_DIR)/ root@$(NIXADDR):/nix-config

	# nixos-rebuild --switch --flake /nix-config#vm-x86_64

bootstrap3:
	scp $(SSHOPTS) -r $(HOME)/.ssh $(NIXUSER)@$(NIXADDR):~/.ssh
	scp $(SSHOPTS) -r $(HOME)/.gnupg $(NIXUSER)@$(NIXADDR):~/.gnupg
