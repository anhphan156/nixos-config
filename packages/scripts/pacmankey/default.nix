{
  stdenvNoCC,
  writeShellApplication,
  pacman,
  sudo,
  src,
  zstd,
  ...
}: let
  archlinux-keyring = stdenvNoCC.mkDerivation {
    pname = "archlinux-keyring";
    version = "latest";
    inherit src;

    nativeBuildInputs = [zstd];

    unpackPhase = ''
      tar -xvf $src
    '';

    installPhase = ''
      mkdir -p $out
      cp -r usr/* $out
    '';
  };
in
  writeShellApplication {
    name = "pacman-key-init";
    runtimeInputs = [pacman sudo];
    text = ''
      sudo pacman-key --init
      sudo pacman-key --populate archlinux --populate-from ${archlinux-keyring}/share/pacman/keyrings/
    '';
  }
