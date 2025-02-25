{
  lib,
  pkgs,
  config,
  inputs,
  ...
}: let
  inherit (pkgs.lib.attrsets) filterAttrs mapAttrs' mapAttrsToList nameValuePair;

  rebuildAliases = config.cyanea.host
    |> filterAttrs (_: y: y)
    |> (x: assert (x |> mapAttrsToList (k: _: k) |> builtins.length) <= 1; x)
    |> mapAttrs' (x: _: nameValuePair "rebuild" " sudo nixos-rebuild switch --flake ${lib.user.path.nixconf}#${x}");

in {
  options.cyanea.shell.zsh = {
    enable = lib.mkOption {
      description = "Enable zsh";
      type = lib.types.bool;
      default = true;
    };
  };

  config = lib.mkIf config.cyanea.shell.zsh.enable {
    programs.zsh.enable = true;
    users.users."${lib.user.name}".shell = pkgs.zsh;

    home-manager.users."${lib.user.name}" = lib.mkMerge [
      {
        programs.zsh.shellAliases = rebuildAliases;
      }
      (import "${inputs.self}/modules/home-manager/dotfiles/shell/zsh.nix")
    ];
  };
}
