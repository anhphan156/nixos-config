{self, ...}: {
  flake.nixosModules = {
    core = {
      imports = with self.nixosModules; [
        nixConfig
        nixpkgsConfig
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

    desktop = {
      imports = with self.nixosModules; [
        pipewire
        font
        sddm
        librewolf
        kitty
      ];
    };
  };
}
