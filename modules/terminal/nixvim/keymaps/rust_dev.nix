{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.nixvim.enable {
    programs.nixvim = {
      files = {
        "ftplugin/rust.lua" = {
          keymaps = [
            {
              action = "<cmd>! cargo clean<cr>";
              key = "<leader>cl";
              options.silent = true;
              mode = "n";
            }
            {
              action = "<cmd>! cargo build<cr>";
              key = "<leader>cc";
              options.silent = true;
              mode = "n";
            }
            {
              # action = "<cmd>FloatermNew --autoclose=0 --width=0.7 --height=0.9 make run<cr>";
              action = "<cmd>! tmux send-keys -t :.+1 \" cargo run\" Enter<CR>";
              key = "<leader>cr";
              options.silent = true;
              mode = "n";
            }
          ]; # keymaps
        }; # ftplugin/rust.lua
      }; # files
    }; # program.nixvim
  }; # config
}
