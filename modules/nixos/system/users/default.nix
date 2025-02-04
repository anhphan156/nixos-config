{lib, ...}: {
  users.users."${lib.user.name}" = {
    isNormalUser = true;
    extraGroups = ["wheel"];
  };
}
