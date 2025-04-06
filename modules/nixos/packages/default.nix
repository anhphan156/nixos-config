{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: let
  guiCfg = config.cyanea.graphical.gui.enable;
in {
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    cmake
    gnumake
    curl
    file
    neovim
    cachix
    alejandra
    (let
      base = pkgs.appimageTools.defaultFhsEnvArgs;
    in
      buildFHSEnv (base
        // {
          name = "fhs";
          inherit (base) targetPkgs;
          profile = "export FHS=1";
          runScript = "bash";
          extraOutputsToInstall = ["dev"];
        }))
  ];

  home-manager.users.${lib.user.name}.imports =
    lib.singleton "${inputs.self}/modules/home-manager/packages/console.nix"
    ++ lib.optional guiCfg "${inputs.self}/modules/home-manager/packages/gui.nix";
}
