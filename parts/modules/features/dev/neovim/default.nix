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
      nvimInit = "${inputs.dotfiles}/config/nvim/init.lua";
      nvimConfig = "${inputs.dotfiles}/config/nvim/config";
      nvimSnippets = "${inputs.dotfiles}/config/nvim/snippets";
    };
  };
}
