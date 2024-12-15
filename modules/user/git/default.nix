{lib, ...}: {
  home-manager.users."${lib.user.name}" = {
    programs.git = {
      enable = true;
      userName = lib.user.git_name;
      userEmail = lib.user.git_email;
    };
  };
}
