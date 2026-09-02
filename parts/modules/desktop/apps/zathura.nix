{
  inputs,
  moduleWithSystem,
  ...
}:
{

  flake.modules.nixos.desktop = moduleWithSystem (
    { self', ... }: {
      environment.systemPackages = [
        self'.packages.zathura
      ];
    }
  );
  perSystem = { pkgs, ... }: {
    packages.zathura =
      (inputs.wrappers.wrapperModules.zathura.apply {
        inherit pkgs;
        settings = {
          default-fg = "#EEEEEE";
        };
        extraConfig = ''
          set recolor true
          set recolor-keephue true
        '';
      }).wrapper;
  };
}
