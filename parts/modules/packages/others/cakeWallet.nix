{
  perSystem = { pkgs, ... }: {
    packages.cakeWallet = pkgs.callPackage (
      {
        stdenv,
        fetchurl,
        lib,
        gtk3,
        sqlite,
        autoPatchelfHook,
        makeWrapper,
        makeDesktopItem,
        copyDesktopItems,
        ...
      }:
      stdenv.mkDerivation (finalAttrs: {
        pname = "cake_wallet";
        version = "6.3.2";

        src = fetchurl {
          url = "https://github.com/cake-tech/cake_wallet/releases/download/v${finalAttrs.version}/Cake_Wallet_v6.3.0_Linux.tar.xz";
          hash = "sha256-+UK9cpa/c64WnN9ATCPRISdJK598qgjXqExh0jicd20=";
        };

        nativeBuildInputs = [
          autoPatchelfHook
          makeWrapper
          copyDesktopItems
        ];
        buildInputs = [
          gtk3
        ];

        installPhase = ''
          runHook preInstall

          mkdir -p "$out/bin"
          cp -r * "$out/bin/"

          install -Dm644 \
            "$out/bin/data/flutter_assets/assets/images/app_logo.png" \
            "$out/share/icons/hicolor/256x256/apps/cakewallet.png"

          runHook postInstall
        '';

        postFixup = ''
          wrapProgram $out/bin/cake_wallet \
                  --prefix LD_PRELOAD : ${sqlite.out}/lib/libsqlite3.so.0 \
                  --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath [ sqlite.out ]}:$out/bin/lib'';

        desktopItems = [
          (makeDesktopItem {
            name = "cakewallet";
            exec = "cake_wallet";
            icon = "cakewallet";
            desktopName = "Cake Wallet";
            categories = [
              "Utility"
            ];
          })
        ];

        meta = {
          mainProgram = "cake_wallet";
        };
      })
    ) { };
  };
}
