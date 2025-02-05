{lib, ...}: {
  home.username = lib.user.name;
  home.homeDirectory = "/home/${lib.user.name}";
}
