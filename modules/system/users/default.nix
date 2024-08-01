{user, ...}: {
  users.users."${user.name}" = {
    isNormalUser = true;
    extraGroups = ["wheel"];
  };
}
