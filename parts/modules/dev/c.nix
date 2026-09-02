{
  flake.modules.nixos.dev = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      llvmPackages.clang-tools
      gcc
      valgrind
      gdb
      gf
    ];
  };
}
