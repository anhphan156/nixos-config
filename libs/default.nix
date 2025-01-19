{inputs}: _: _: let
  user = rec {
    name = "backspace";
    git_name = name;
    git_email = "anh.phan156@protonmail.com";
    path = {
      dev = "/home/${name}/data/dev";
      music = "/home/${name}/data/Music";
      screenshot = "/home/${name}/data/Pictures/screenshots";
      mpd = "/home/${name}/.local/share/mpd";
      nixconf = "/home/${name}/data/dev/nixos-config";
      docker = "/home/${name}/data/docker";
    };
  };
in {
  inherit user;

  enabled = {
    enable = inputs.nixpkgs.lib.mkForce true;
  };

  install = packages: {users."${user.name}".home.packages = packages;};

  getNixFiles = path: import ./getNixFiles {inherit path;};
}
