{pkgs, ...}: {
  environment = {
    systemPackages = with pkgs; [
      arch-install-scripts
      pacman
    ];

    etc = {
      "pacman.d/mirrorlist" = {
        enable = true;
        source = pkgs.stdenv.mkDerivation {
          pname = "mirrorlist";
          version = "1.0.0";
          src = pkgs.fetchurl {
            url = "https://archlinux.org/mirrorlist/?country=US&protocol=http&protocol=https&ip_version=4";
            sha256 = "sha256-ukdIFhmmtg+a5inbygwfbSYJ8IZCt29nQ7IYWryQeU4=";
          };
          unpackPhase = ''
            cp --no-preserve=mode $src text.txt
          '';
          patchPhase = ''
            sed 's/^.\(.*\)/\1/' text.txt > mirrorlist
          '';
          installPhase = ''
            cat mirrorlist > $out
          '';
        };
      };
      "pacman.conf" = {
        enable = true;
        text = ''
          [options]
          ParallelDownloads = 5
          Architecture = auto
          HoldPkg = pacman glibc
          SigLevel = Never
          Color
          Checkspace

          [core]
          #SigLevel = PackageRequired
          Include = /etc/pacman.d/mirrorlist
          [extra]
          #SigLevel = PackageRequired
          Include = /etc/pacman.d/mirrorlist
          [community]
          #SigLevel = PackageRequired
          Include = /etc/pacman.d/mirrorlist
        '';
      };
    }; # etc
  }; # environment

  systemd.services."SetupPacman" = {
    description = "Create directory /var/lib/pacman";
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = ''
        ${pkgs.coreutils}/bin/mkdir -p /var/lib/pacman
      '';
    };
  };
}
