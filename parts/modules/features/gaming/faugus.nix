{
  flake.modules.nixos.faugus = { pkgs, config, ... }: {
    environment.systemPackages = with pkgs; [
      faugus-launcher
    ];

    # additional preservation
    preservation.preserveAt."/persistence" = {
      users."${config.username}" = {
        directories = [
          ".config/faugus-launcher"
          ".local/share/umu"
        ];
      };
    };

  };
}
