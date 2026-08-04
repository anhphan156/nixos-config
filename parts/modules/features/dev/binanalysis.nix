{
  flake.nixosModules = {
    binaryAnalysis = { pkgs, ... }: {
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
  };
}
