{
  stdenv,
  writeShellApplication,
  pacman,
  sudo,
  ...
}: let
  archlinux-keyring = stdenv.mkDerivation {
    pname = "archlinux-keyring";
    version = "1.0.0";
    src = builtins.fetchTarball {
      url = "https://archlinux.org/packages/core/any/archlinux-keyring/download/";
      sha256 = "0mngzf3j8q0s2jk1820351xv61233plz461gqxlvkhwghg8fn140";
    };
    installPhase = ''
      cp -r $src $out
    '';
  };
in
  writeShellApplication {
    name = "pacman-key-init";
    runtimeInputs = [pacman sudo];
    text = ''
      sudo pacman-key --init
      sudo pacman-key --populate archlinux --populate-from ${archlinux-keyring}/usr/share/pacman/keyrings/
    '';
  }
