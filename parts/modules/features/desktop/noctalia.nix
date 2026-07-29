{ inputs, ... }: {
  perSystem =
    {
      pkgs,
      lib,
      ...
    }:
    {
      packages.noctalia =
        (inputs.wrappers.wrapperModules.noctalia.apply {
          inherit pkgs;
          package = pkgs.noctalia;
          settings = (lib.fromTOML <| builtins.readFile "${inputs.dotfiles}/config/noctalia/config.toml") // {
            wallpaper = {
              directory = "${inputs.dotfiles}/misc/wallpapers/single";
              automation = {
                enabled = true;
                interval_seconds = 300;
              };
            };
          };
        }).wrapper;
    };
}
