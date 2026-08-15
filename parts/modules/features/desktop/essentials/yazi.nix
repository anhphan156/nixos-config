{
  inputs,
  ...
}:
{
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
