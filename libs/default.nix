{inputs}: _: _: let
  user = rec {
    name = "backspace";
    git_name = "anhphan";
    git_email = "anh.phan156@protonmail.com";
    path = {
      root = inputs.self.src;
      dev = "/home/${name}/data/dev";
      dotfiles = "/home/${name}/dotfiles";
      music = "/home/${name}/data/Music";
    };
  };
in {
  inherit user;

  enabled = import ./enabled {inherit inputs;};

  # config.home-manager = install [ pkgs.<name> ];
  install = packages: {users."${user.name}".home.packages = packages;};

  getNixFiles = path: import ./getNixFiles {inherit path;};
}
