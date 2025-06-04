require("luasnip.loaders.from_vscode").lazy_load()

local cmp = require("cmp")

local opts = {
  mapping = cmp.mapping.preset.insert({
    ["<Esc>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ["<s-Tab>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
 --   ["<Tab>"] = function (fallback)
 --     if cmp.visible() then
 --       cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert, })
 --       fallback()
 --     else
 --       --vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Tab>', true, true, true), 'n', true)
 --     end
 --   end,
 --   ["<s-Tab>"] = function (fallback)
 --     if cmp.visible() then
 --       cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert, })
 --       fallback()
 --     end
 --   end,
    ['<Down>'] = function(fallback)
      if cmp.visible() then
        cmp.close()
        fallback()
      else
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Down>', true, true, true), 'n', true)
      end
    end,
    ['<Up>'] = function(fallback)
      if cmp.visible() then
        cmp.close()
        fallback()
      else
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Up>', true, true, true), 'n', true)
      end
    end,
    ['<Left>'] = function(fallback)
      if cmp.visible() then
        cmp.close()
        fallback()
      else
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Left>', true, true, true), 'n', true)
      end
    end,
    ['<Right>'] = function(fallback)
      if cmp.visible() then
        cmp.close()
        fallback()
      else
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Right>', true, true, true), 'n', true)
      end
    end,
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    --{ name = "codeium" },
  }, {
    { name = "buffer" },
  }),
  formatting = {
    format = require("lspkind").cmp_format({
      mode = 'symbol_text', -- show only symbol annotations
      maxwidth = {
        menu = 50,
        abbr = 50,
      },
      ellipsis_char = '...',
      show_labelDetails = true,

      before = function (entry, vim_item)
        return vim_item
      end
    })
  }
}

require("cmp").setup(opts)
