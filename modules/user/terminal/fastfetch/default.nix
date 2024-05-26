{
  config,
  lib,
  user,
  rootPath,
  ...
}: {
  config = {
    home-manager.users."${user.name}" = {config, ...}: {
      programs.zsh = {
        initExtra = lib.mkBefore ''
          fastfetch
        '';
      };

      xdg.configFile = {
        "fastfetch/".source = config.lib.file.mkOutOfStoreSymlink (rootPath + /config/fastfetch);
      };
    };
  };
}
