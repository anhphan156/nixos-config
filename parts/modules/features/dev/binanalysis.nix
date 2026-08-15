{
  flake.modules.nixos.dev = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      imhex
      ghidra
      radare2

      file
      xxd
      ltrace
      ascii
    ];
  };
}
