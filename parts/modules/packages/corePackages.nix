{
  flake.modules.nixos.core = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      file
      fd
      ripgrep
      wget
      killall
      nix-prefetch-git
      unzip
      zip
      jq
    ];
  };
}
