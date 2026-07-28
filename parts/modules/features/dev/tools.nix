{
  flake.nixosModules = {
    binaryAnalysis = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        imhex
        ghidra
      ];
    };
  };
}
