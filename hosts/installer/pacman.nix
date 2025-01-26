{
  pkgs,
  inputs,
  ...
}: {
  environment = {
    systemPackages = with pkgs; [
      arch-install-scripts
      (callPackage (inputs.self + /packages/user_scripts/pacmankey) {src = inputs.archlinux-keyring;})
    ];

    etc = {
      "pacman.d/mirrorlist" = {
        enable = true;
        source = pkgs.stdenv.mkDerivation {
          pname = "mirrorlist";
          version = "1.0.0";
          src = inputs.archlinux-mirrorlist;

          unpackPhase = ''
            cat $src > mirrorlist
          '';
          patchPhase = ''
            sed -i 's/^.\(.*\)/\1/' mirrorlist
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
          SigLevel = Required DatabaseOptional
          LocalFileSigLevel = Optional
          Color
          CheckSpace

          [core]
          Include = /etc/pacman.d/mirrorlist
          [extra]
          Include = /etc/pacman.d/mirrorlist
          [community]
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
