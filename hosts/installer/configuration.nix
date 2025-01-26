#nix build .#nixosConfigurations.installer.config.system.build.isoImage
{
  pkgs,
  lib,
  inputs,
  ...
}: {
  users.users."${lib.user.name}".initialPassword = "123";

  hardware.enableAllFirmware = true;

  environment.systemPackages = with pkgs; [
    disko
  ];
  home-manager.users.${lib.user.name} = {
    home.file."disko-repo".source = inputs.disko;
  };

  systemd.services.sshd.wantedBy = lib.mkForce ["multi-user.target"];

  networking.wireless.enable = lib.mkForce false;
  cyanea = {
    desktopApp = {
      firefox = lib.enabled;
    };
    graphical = {
      gui = lib.enabled;
      hyprland = lib.enabled;
    };
    terminal.tmux = lib.enabled;
    system = {
      hostname = "NixosIntallerISO";
      xremap = lib.enabled;
      pipewire = lib.enabled;
    };
  };
}
