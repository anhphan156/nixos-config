{
  flake.nixosModules.c = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      llvmPackages.clang-tools
      gcc
      valgrind
      gdb
      gf
    ];
  };
}
