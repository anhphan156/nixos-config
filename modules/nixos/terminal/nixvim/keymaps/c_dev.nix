{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf (config.nixvim.enable && config.cyanea.dev.c.enable) {
    programs.nixvim = {
      files = let
        c_maps.keymaps = [
          {
            action = "<cmd>! make clean<cr>";
            key = "<leader>cl";
            options.silent = true;
            mode = "n";
          }
          {
            # action = "<cmd>! make<cr>";
            action = "<cmd>! tmux send-keys -t :.+1 \" make\" Enter<CR>";
            key = "<leader>cc";
            options.silent = true;
            mode = "n";
          }
          {
            # action = "<cmd>FloatermNew --autoclose=0 --width=0.7 --height=0.9 make run<cr>";
            action = "<cmd>! tmux send-keys -t :.+1 \" make run\" Enter<CR>";
            key = "<leader>cr";
            options.silent = true;
            mode = "n";
          }
          {
            action = let
              new_window = pkgs.writeShellScriptBin "neww" ''
                window=$(${lib.getExe pkgs.tmux} new-window -PF "#D")
                ${lib.getExe pkgs.tmux} send-keys -t $window " gdbx out $window" Enter
              '';
            in "<cmd>!${lib.getExe new_window}<cr>";
            key = "<leader>d";
            options.silent = true;
            mode = "n";
          }
        ];
      in {
        "ftplugin/c.lua" = {
          inherit (c_maps) keymaps;
        };
        "ftplugin/cpp.lua" = {
          inherit (c_maps) keymaps;
        };
        "ftplugin/asm.lua" = {
          inherit (c_maps) keymaps;
        };
      };
    };
  };
}
