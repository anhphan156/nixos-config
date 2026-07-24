#nix build .#nixosConfigurations.liveusb.config.system.build.isoImage
{
  pkgs,
  lib,
  config,
  inputs,
  modulesPath,
  ...
}: {
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-graphical-base.nix"
  ];

  users.users."${lib.user.name}".initialPassword = "123";

  # boot.kernelModules = ["brcmfmac"];
  boot.kernelModules = ["wl"];
  boot.blacklistedKernelModules = ["b43" "bcma"];
  boot.extraModulePackages = with config.boot.kernelPackages; [broadcom_sta];
  hardware.enableAllFirmware = true;

  environment = {
    systemPackages = with pkgs; [
      disko
    ];
  };

  home-manager.users.${lib.user.name} = {
    home.file."disko-repo".source = inputs.disko;
  };

  networking.wireless.enable = lib.mkForce false;
  cyanea = {
    desktopApp = {
      librewolf = lib.enabled;
      firefox = lib.enabled;
    };
    graphical = {
      gui = lib.enabled;
      hyprland = lib.enabled;
    };
    terminal.tmux = lib.enabled;
    shell = {
      xonsh = lib.enabled;
    };
    system = {
      hostname = "NixosIntallerISO";
      xremap = lib.enabled;
      pipewire = lib.enabled;
    };
  };
}
