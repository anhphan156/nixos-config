{ self, ... }: {
  flake.nixosModules = {
    core = {
      imports = with self.nixosModules; [
        nixConfig
        nixpkgsConfig
        nixld
        constants
        bootloader
        locale
        user
        sudo
        network
        git
        neovim
      ];
    };

    fancyShell = {
      imports = with self.nixosModules; [
        fastfetch
        starship
        zsh
        tmux
      ];
    };

    dev = {
      imports = with self.nixosModules; [
        direnv
      ];
    };

    desktop = {
      imports = with self.nixosModules; [
        pipewire
        font
        librewolf
        kitty
      ];
    };
  };
}
