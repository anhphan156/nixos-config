{
  perSystem =
    { pkgs, self', ... }:
    let
      mscreenshot =
        {
          stdenv,
          pkg-config,
          meson,
          ninja,
          cmake,
          wayland-protocols,
          wayland-scanner,
          wayland,
          cairo,
          libxkbcommon,
          cjson,
          imagemagick,
          scdoc,
          makeWrapper,
          fetchFromGitHub,
          ...
        }:
        stdenv.mkDerivation {
          name = "mscreenshot";
          version = "0.0.1";
          src = fetchFromGitHub {
            owner = "anhphan156";
            repo = "mscreenshot";
            rev = "1be2e8a6f6a2cd0d7354fb499e3f5b4b1e7cff2f";
            hash = "sha256-v7BPXtYerqELuwngbVYxuRPGwCOb2wWFJCJC389S5Qg=";
            fetchSubmodules = true;
          };

          depsBuildBuild = [ pkg-config ];
          strictDeps = true;

          nativeBuildInputs = [
            meson
            ninja
            pkg-config
            cmake
            scdoc
            makeWrapper
            wayland-protocols
            wayland-scanner
          ];

          buildInputs = [
            wayland
            cairo
            libxkbcommon
            cjson
            imagemagick.dev
          ];

          meta = {
            mainProgram = "mscreenshot";
          };
        };

      screenshotScript =
        {
          writeShellApplication,
          grim,
          slurp,
          wl-clipboard,
          gawk,
          imagemagick,
          libnotify,
          wallpapers,
          formats,
          mscreenshot,
          noctalia,
          ...
        }:
        let
          screenshot_config = (formats.json { }).generate "meme_screenshot_config.json" {
            sparkle = {
              stickers = [
                {
                  path = "${wallpapers}/stickers/sparkle.png";
                  pivot = 3;
                  anchor = 3;
                  scale = 1;
                }
              ];
            };
            anya = {
              stickers = [
                {
                  path = "${wallpapers}/stickers/anya.png";
                  pivot = 3;
                  anchor = 3;
                  scale = 0.4;
                }
              ];
            };
            yae = {
              stickers = [
                {
                  path = "${wallpapers}/stickers/twosoyjaklumine.png";
                  pivot = 3;
                  anchor = 3;
                  scale = 0.4;
                }
                {
                  path = "${wallpapers}/stickers/twosoyjakyae.png";
                  pivot = 2;
                  anchor = 2;
                  scale = 0.4;
                }
              ];
            };
          };
        in
        writeShellApplication {
          name = "screenshot-script";
          runtimeInputs = [
            mscreenshot
            grim
            slurp
            wl-clipboard
            gawk
            imagemagick
            libnotify
            noctalia
          ];
          text = ''
            copy() {
            	wl-copy -t image/png < "$out"
            	notify-send "Screenshot" "Screenshot is available in the clipboard" -t 3000 --icon=${wallpapers}/icons/camera_04.png
            }

            main() {
            	templates=(sparkle yae anya bordered)
            	template=$(printf "%s\n" "''${templates[@]}" | noctalia dmenu -p "Enter a style")

            	random_name=$(head /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 30)
            	fg="/tmp/$random_name-fg.png"
            	out="/tmp/$random_name-output.png"

            	if [[ "$template" == "bordered" ]]; then
            		region=$(slurp -d)
            		dimension=$(echo "$region" | awk '{print $2}')
            		w=$(echo "$dimension" | cut -d'x' -f1)
            		h=$(echo "$dimension" | cut -d'x' -f2)

                m=10
                r=15

                grim -g "$region" -t png "$fg"

                magick -size "$((w+m*2))x$((h+m*2))" xc:none \
                  -fill plasma:#abcdef-#ef9889 -draw "roundrectangle 0,0 $((w+m*2)),$((h+m*2)) $r,$r" \
                  -fill "$fg" -draw "roundrectangle $((m+2)),$((m+2)) $((w+m-2)),$((h+m-2)) $r,$r" \
                  "$out"

                copy "$out"
                rm "$fg" "$out"
            	else
            		MEME_SCREENSHOT_CONFIG=${screenshot_config} mscreenshot -s "$template" -o "$out"

            		copy "$out"
            		rm "$out"
            	fi
            }

            main "$@"
          '';
        };
    in
    {
      packages.screenshotScript = pkgs.callPackage screenshotScript {
        inherit (self'.packages) noctalia;
        mscreenshot = pkgs.callPackage mscreenshot { };
      };
    };
}
