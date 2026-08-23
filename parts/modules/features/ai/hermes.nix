{ inputs, ... }: {
  flake.modules.nixos.hermes = { config, ... }: {
    imports = [ inputs.hermes-agent.nixosModules.default ];
    services.hermes-agent = {
      enable = true;
      container = {
        enable = true;
        image = "ubuntu:24.04";
        hostUsers = [ config.username ];
      };
      settings = {
        model = {
          provider = "custom";
          default = "Qwen3.5-9B-GGUF:UD-Q4_K_XL";
          base_url = "http://localhost:8080/v1";
        };

        display = {
          compact = false;
          personality = "kawaii";
        };
        memory = {
          memory_enabled = true;
          user_profile_enabled = true;
        };
      };
      extraDependencyGroups = [ "messaging" ];
      addToSystemPackages = true;
      stateDir = "/persistence/ai/state";
      workingDirectory = "/persistence/ai/working";
    };
  };
}
