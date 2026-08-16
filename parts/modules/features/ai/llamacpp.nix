{
  flake.modules.nixos.llamacpp = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      llama-cpp-vulkan
    ];
  };
}
