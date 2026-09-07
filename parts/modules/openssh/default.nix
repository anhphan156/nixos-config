{
  flake.modules.nixos.openssh = { config, ... }: {

    users.users.${config.username} = {
      initialPassword = "123";
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB82m11CRIDRpMb2+XyvsOYjekaCvKJL3lN+nZf3rYla openpgp:0x86A78EF3"
      ];
    };

    services.openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "prohibit-password";
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
      };
    };

    networking.firewall.allowedTCPPorts = [
      22
    ];
  };
}
