{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.nixvim.enable {
    programs.nixvim = {
      keymaps = lib.mkBefore [
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
          action = "<cmd>! tmux send-keys -t :.+1 C-c<CR>";
          key = "<leader>cs";
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
          action = "<cmd>lua require'telescope.builtin'.lsp_document_symbols{}<cr>";
          key = "<leader>fs";
          options.silent = true;
          mode = "n";
        }
        {
          action = "<cmd>lua require'telescope.builtin'.lsp_references{}<cr>";
          key = "<leader>fr";
          options.silent = true;
          mode = "n";
        }
        {
          action = "<cmd>lua require'telescope.builtin'.diagnostics{}<cr>";
          key = "<leader>fd";
          options.silent = true;
          mode = "n";
        }
        {
          action = "<cmd>Telescope current_buffer_fuzzy_find<cr>";
          key = "<leader>fb";
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
          action.__raw = ''
            function()
            	local ls = require("luasnip")
            	ls.jump(-1)
            end
          '';
          key = "<C-h>";
          options.silent = true;
          mode = "i";
        }
        {
          action.__raw = ''
            function()
            	local ls = require("luasnip")
            	ls.jump(1)
            end
          '';
          key = "<C-l>";
          options.silent = true;
          mode = "i";
        }
      ]; #keymaps
    };
  };
}
