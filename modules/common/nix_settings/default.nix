{
  nix = {
    gc = {
      automatic = true;
      options = "--delete-older-than 3d";
    };

    settings = {
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes" "pipe-operators"];
    };
  };
}
