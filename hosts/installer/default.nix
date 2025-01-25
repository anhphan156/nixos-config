#nix build .#nixosConfigurations.installer.config.system.build.isoImage
{
  pkgs,
  modulesPath,
  lib,
  inputs,
  ...
}: {
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  users.users."${lib.user.name}".initialPassword = "123";

  nixpkgs.hostPlatform = "x86_64-linux";
  nixpkgs.config.allowUnfree = true;
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
      awesome = lib.enabled;
    };
    shell = {
      xonsh = lib.enabled;
    };
    terminal.tmux = lib.enabled;
    system = {
      hostname = "NixosIntallerISO";
      xremap = lib.enabled;
      pipewire = lib.enabled;
    };
  };
}
