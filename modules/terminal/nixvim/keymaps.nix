{
  config,
  lib,
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
      ];
    };
  };
}
