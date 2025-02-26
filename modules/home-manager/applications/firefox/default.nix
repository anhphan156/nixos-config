{
  inputs,
  lib,
  ...
}: {
  # home.packages = lib.mkIf cfg.spacebar.enable [
  #   (pkgs.writeShellScriptBin "ffspacebar" ''
  #     firefox -P spacebar
  #   '')
  # ];
}
