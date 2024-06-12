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
        # floaterm
        {
          action = ":FloatermToggle<CR>";
          key = "<leader>rt";
          options.silent = true;
          mode = "n";
        }

        # lspsaga
        {
          action = ":Lspsaga hover_doc<CR>";
          key = "<leader>sh";
          options.silent = true;
          mode = "n";
        }
        {
          action = ":Lspsaga code_action<CR>";
          key = "<leader>sa";
          options.silent = true;
          mode = "n";
        }
        {
          action = ":Lspsaga peek_definition<CR>";
          key = "<leader>sd";
          options.silent = true;
          mode = "n";
        }
        {
          action = ":Lspsaga rename<CR>";
          key = "<leader>sr";
          options.silent = true;
          mode = "n";
        }

        # telescope
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
        # running C code
        {
          action = "<cmd>! make clean<cr>";
          key = "<leader>cl";
          options.silent = true;
          mode = "n";
        }
        {
          action = "<cmd>! make<cr>";
          key = "<leader>cc";
          options.silent = true;
          mode = "n";
        }
        {
          action = "<cmd>FloatermNew --autoclose=0 --width=0.7 --height=0.9 make run<cr>";
          key = "<leader>cr";
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
