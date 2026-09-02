{
  inputs,
  moduleWithSystem,
  ...
}:
{
  flake.modules.nixos.shell = moduleWithSystem (
    { self', ... }: {
      environment.systemPackages = [
        self'.packages.yazi
      ];
    }
  );
  perSystem = { pkgs, ... }: {
    packages.yazi =
      (inputs.wrappers.wrapperModules.yazi.apply {
        inherit pkgs;
        settings = { };
        keymap = { };
        theme = { };
      }).wrapper;
  };
}
