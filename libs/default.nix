{
  inputs,
  user,
}: _: _: {
  enabled = import ./enabled {inherit inputs;};

  # config.home-manager = install [ pkgs.<name> ];
  install = packages: {users."${user.name}".home.packages = packages;};

	getNixFiles = path : import ./imports { inherit path; };
}
