{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.nixvim.enable {
    programs.nixvim = {
      files = {
        "ftplugin/nix.lua" = {
          keymaps = [
            {
              action = "<cmd>! tmux send-keys -t :.+1 \" rebuild\" Enter<CR>";
              key = "<leader>cr";
              options.silent = true;
              mode = "n";
            }
          ];
        }; # ftplugin/nix.lua
      }; # files
    };
  };
}
