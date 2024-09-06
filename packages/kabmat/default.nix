pkgs:
pkgs.stdenv.mkDerivation {
  name = "kabmat";
  src = pkgs.fetchFromGitHub {
    owner = "PlankCipher";
    repo = "kabmat";
    rev = "02518704976d108a356d685bf351de17142dd76f";
    sha256 = "07d6r8gwx6yr4hdks41nn9b1i60c61cba408ymsdzh6ajk0d4x01";
  };
  nativeBuildInputs = with pkgs; [gcc ncurses];
  buildPhase = "export HOME=$(mktemp -d) && make";
  installPhase = ''
    mkdir -p $out/bin
    cp kabmat $out/bin
  '';
}
