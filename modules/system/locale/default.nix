{lib, ...}: {
  # Set your time zone.
  time.timeZone = "America/Toronto";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  home-manager.users."${lib.user.name}".programs.zsh = {
    envExtra = ''
      export LC_ALL=en_CA.UTF-8
      export LANG=en_CA.UTF-8
    '';
  };

  services.openssh = {
    extraConfig = "AcceptEnv LANG LANGUAGE LC_*";
  };
}
