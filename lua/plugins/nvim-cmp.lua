return function ()
  local cmp = require 'cmp'
  local luasnip = require 'luasnip'

  local function check_backspace()
    local col = vim.fn.col '.' - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match '%s' ~= nil
  end

  local next_item_keys = vim.api.nvim_replace_termcodes('<c-n>', true, true, true)
  local prev_item_keys = vim.api.nvim_replace_termcodes('<c-p>', true, true, true)
  local backspace_keys = vim.api.nvim_replace_termcodes('<tab>', true, true, true)
  local snippet_next_keys = vim.api.nvim_replace_termcodes('<plug>luasnip-expand-or-jump', true, true, true)
  local snippet_prev_keys = vim.api.nvim_replace_termcodes('<plug>luasnip-jump-prev', true, true, true)

  cmp.setup {
    completion = { completeopt = 'menu,menuone,noinsert' },
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end
    },
    formatting = {
      format = function(_, vim_item)
        vim_item.kind = require('lspkind').presets.default[vim_item.kind] .. ' ' .. vim_item.kind
        return vim_item
      end
    },
    mapping = {
      ["<C-p>"] = cmp.mapping.select_prev_item(),
      ["<C-n>"] = cmp.mapping.select_next_item(),
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.close(),
      ["<CR>"] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false
      },
      ['<Tab>'] = function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
        else
          fallback()
        end
      end,
      ['<S-Tab>'] = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
        else
          fallback()
        end
      end
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'buffer' },
      { name = 'path' },
      { name = 'nvim_lua' },
    },
  }
end
