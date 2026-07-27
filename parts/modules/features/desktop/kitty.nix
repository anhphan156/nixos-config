{
  moduleWithSystem,
  inputs,
  ...
}: {
  flake.nixosModules.kitty = moduleWithSystem ({self', ...}: {
    environment.systemPackages = [
      self'.packages.kitty
    ];
  });
  perSystem = {pkgs, ...}: {
    packages.kitty = pkgs.callPackage ({
      symlinkJoin,
      makeWrapper,
      kitty,
    }:
      symlinkJoin {
        name = "my-kitty";
        paths = [kitty];
        nativeBuildInputs = [makeWrapper];
        postBuild = ''
          wrapProgram $out/bin/kitty \
            --add-flags "-c" \
            --add-flags "${inputs.dotfiles}/config/kitty/kitty.conf"
        '';
        meta.mainProgram = "kitty";
      }) {};
  };
}
