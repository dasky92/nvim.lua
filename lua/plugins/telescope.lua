require('telescope').setup{
  defaults = {
    layout_strategy = 'flex',
    scroll_strategy = 'cycle',
  },
  extensions = {
    -- frecency = { workspaces = { exo = vim.fn.stdpath('data').."telescope/frecency"}},
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = 'smart_case',
    },
  },
  pickers = {
    lsp_references = { theme = 'dropdown' },
    lsp_code_actions = { theme = 'dropdown' },
    lsp_definitions = { theme = 'dropdown' },
    lsp_implementations = { theme = 'dropdown' },
    buffers = {
      sort_lastused = true,
      previewer = false,
    },
  },
}
