{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.nixvim.enable {
    programs.nixvim = {
      keymaps = [
        {
          action = "<esc>";
          key = "jk";
          options.silent = true;
          mode = "i";
        }
        {
          action = "<esc>:w<CR>";
          key = "<leader>w";
          options.silent = true;
          mode = "n";
        }
        {
          action = "<esc>Vy";
          key = "Y";
          options.silent = true;
          mode = "n";
        }
        {
          action = ":NvimTreeToggle<CR>";
          key = "<leader>t";
          options.silent = true;
          mode = "n";
        }
        {
          action = "<cmd>Telescope current_buffer_fuzzy_find<cr>";
          key = "<leader>fr";
          options.silent = true;
          mode = "n";
        }
        {
          action = "<cmd>Telescope find_files<cr>";
          key = "<leader>ff";
          options.silent = true;
          mode = "n";
        }
        {
          action = "<cmd>Telescope live_grep<cr>";
          key = "<leader>fg";
          options.silent = true;
          mode = "n";
        }
        {
          action = let
						tmux = "${pkgs.tmux}/bin/tmux";
            new_window = pkgs.writeShellScriptBin "neww" ''
							window=$(${tmux} new-window -PF "#D")
							${tmux} send-keys -t $window " gdbx out $window" Enter
						'';
          in "<cmd>!${new_window}/bin/neww<cr>";
          key = "<leader>d";
          options.silent = true;
          mode = "n";
        }
      ];
    };
  };
}
