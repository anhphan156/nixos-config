{inputs}: _: _: let
  user = rec {
    name = "backspace";
    git_name = name;
    git_email = "anh.phan156@protonmail.com";
    path = {
      root = inputs.self.src;
      dev = "/home/${name}/data/dev";
      music = "/home/${name}/data/Music";
      dot = "/home/${name}/dotfiles";
    };
  };
in {
  inherit user;

  enabled = import ./enabled {inherit inputs;};

  # config.home-manager = install [ pkgs.<name> ];
  install = packages: {users."${user.name}".home.packages = packages;};

  getNixFiles = path: import ./getNixFiles {inherit path;};
}
