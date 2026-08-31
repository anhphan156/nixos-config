{
  lib,
  config,
  ...
}:
{
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.loader.grub.enable = lib.mkForce false;
  boot.supportedFilesystems.zfs = lib.mkForce false;
  boot.consoleLogLevel = lib.mkForce 7;
  hardware.raspberry-pi.firmware.uboot.enable = true;
  sdImage.compressImage = false;

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "prohibit-password";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };

  users.users.${config.username} = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB82m11CRIDRpMb2+XyvsOYjekaCvKJL3lN+nZf3rYla openpgp:0x86A78EF3"
    ];
  };

  networking.networkmanager.ensureProfiles.profiles."home" = {
    connection = {
      id = "home-wifi";
      # permissions = "";
      type = "wifi";
    };
    ipv4 = {
      # dns-search = "";
      method = "auto";
    };
    ipv6 = {
      # addr-gen-mode = "stable-privacy";
      # dns-search = "";
      method = "auto";
    };
    wifi = {
      # mac-address-blacklist = "";
      mode = "infrastructure";
      ssid = "";
    };
    wifi-security = {
      # auth-alg = "open";
      key-mgmt = "wpa-psk";
      psk = "";
    };
  };

  # environment.etc."NetworkManager/system-connections/Weeboo.nmconnection" = {
  #   text = ''
  #     [connection]
  #     id=Weeboo
  #     uuid=2cb7c9ec-31be-490e-8664-242f41831569
  #     type=wifi
  #     interface-name=wlan0
  #     autoconnect=true
  #
  #     [wifi]
  #     mode=infrastructure
  #     ssid=
  #
  #     [wifi-security]
  #     auth-alg=open
  #     key-mgmt=wpa-psk
  #     psk=
  #
  #     [ipv4]
  #     method=auto
  #
  #     [ipv6]
  #     addr-gen-mode=default
  #     method=auto
  #
  #     [proxy]
  #   '';
  #   mode = "0600";
  # };

  system.stateVersion = "26.05";
}
