{
  config,
  lib,
  ...
}:
with lib; {
  config = mkIf config.nixvim.enable {
    programs.nixvim = {
      plugins = {
        cmp_luasnip = enabled;
        cmp-nvim-lsp = enabled;
        cmp = {
          enable = true;
          autoEnableSources = true;
          settings = {
            window = {
              completion = {
                border = "rounded";
                winhighlight = "FloatBorder:NormalFloat";
              };
              documentation = {
                border = "rounded";
                winhighlight = "FloatBorder:NormalFloat";
              };
            };
            mapping = {
              __raw = ''
                cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                    ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'}),
                    ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'}),
                  })
              '';
            };
            sources = [
              {
                name = "nvim_lsp";
              }
              {
                name = "path";
              }
              {
                name = "buffer";
              }
              {
                name = "luasnip";
              }
            ];
            formatting = {
              expandable_indicator = true;
              fields = ["abbr" "kind" "menu"];
            };
            snippet = {
              expand = ''
                function(args)
                	require('luasnip').lsp_expand(args.body)
                end
              '';
            };
          }; # cmp.settings
        }; # cmp

      }; #plugins
    }; # program.nixvim
  }; # config
}
