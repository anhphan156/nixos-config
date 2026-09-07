{
  modulesPath,
  pkgs,
  config,
  ...
}:
{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-graphical-base.nix"
  ];

  users.users.${config.username} = {
    initialPassword = "123";
  };

  environment.systemPackages = with pkgs; [
    disko
  ];
}
