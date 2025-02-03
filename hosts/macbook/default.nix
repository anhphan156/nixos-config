{pkgs, ...}: {
  nixpkgs.hostPlatform = "x86_64-darwin";
  environment.systemPackages = with pkgs; [
    neovim
  ];

  nix.settings = {
    # enable flakes globally
    experimental-features = ["nix-command" "flakes" "pipe-operators"];
  };

  users.users."anhphan" = {
    home = "/Users/anhphan";
    description = "anhphan";
  };

  system = {
    stateVersion = 6;
    activationScripts.postUserActivation.text = ''
      # activateSettings -u will reload the settings from the database and apply them to the current session,
      # so we do not need to logout and login again to make the changes take effect.
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';
  };
}
