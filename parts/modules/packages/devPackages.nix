{
  flake.modules.nixos.dev = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      devenv

      llvmPackages.clang-tools
      gcc
      valgrind
      gdb
      gf

      imhex
      ghidra
      radare2
      xxd
      ltrace
      ascii
    ];
  };
}
