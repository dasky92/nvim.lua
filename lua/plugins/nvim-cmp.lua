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

  require('cmp').setup {
    completion = { completeopt = 'menuone,noinsert' },
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
      ['<cr>'] = cmp.mapping.confirm(),
      ['<tab>'] = cmp.mapping(function(fallback)
        if vim.fn.pumvisible() == 1 then
          vim.fn.feedkeys(next_item_keys, 'n')
        elseif luasnip.expand_or_jumpable() then
          vim.fn.feedkeys(snippet_next_keys, '')
        elseif check_backspace() then
          vim.fn.feedkeys(backspace_keys, 'n')
        else
          fallback()
        end
      end, {
        'i',
        's',
      }),
    },
    ['<s-tab>'] = cmp.mapping(function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(prev_item_keys, 'n')
      elseif luasnip.jumpable(-1) then
        vim.fn.feedkeys(snippet_prev_keys, '')
      else
        fallback()
      end
    end, {
      'i',
      's',
    }),
    sources = {
      { name = 'nvim_lsp' },
      { name = 'buffer' },
      { name = 'luasnip' },
      { name = 'path' },
      { name = 'nvim_lua' },
    },
  }
end
