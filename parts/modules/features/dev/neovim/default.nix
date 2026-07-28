{
  inputs,
  moduleWithSystem,
  ...
}:
{
  flake.nixosModules.neovim = moduleWithSystem (
    { self', ... }: {
      environment.systemPackages = [
        self'.packages.neovim
      ];
    }
  );

  perSystem = { pkgs, ... }: {
    packages.neovim = pkgs.callPackage ./_packages/neovim.nix {
      initLua = "${inputs.dotfiles}/config/neovim/init.lua";
      myConfig = "${inputs.dotfiles}/config/neovim/myConfig";
      snippets = "${inputs.dotfiles}/config/neovim/snippets";
    };
  };
}
