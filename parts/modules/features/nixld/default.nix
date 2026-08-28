{
  flake.modules.nixos.nixld = { pkgs, ... }: {
    programs.nix-ld = {
      enable = true;
      libraries = with pkgs; [
        mesa
        libGL
        libxinerama
        libxcursor
        libxrender
        libxscrnsaver
        libxi
        libsm
        libice

        alsa-lib

        glib
      ];
    };
  };
}
