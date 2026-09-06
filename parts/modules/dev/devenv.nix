{
  flake.modules.nixos.dev = { pkgs, config, ... }: {
    environment.systemPackages = with pkgs; [
      devenv
    ];

    preservation.preserveAt."/persistence" = {
      users."${config.username}" = {
        directories = [
          ".local/share/devenv"
        ];
      };
    };
  };
}
