return function ()
  local fn = vim.fn
  local lsp = vim.lsp

  local lsp_error = ""
  local lsp_warning = ""
  local lsp_hint = ""
  local lsp_information = ""
  local lsp_virtual_text = " "

  -- Snippets support
  local capabilities = lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  -- Lsp Symbols
  fn.sign_define("LspDiagnosticsSignError", {
    texthl = "LspDiagnosticsSignError",
    text = lsp_error,
    numhl = "LspDiagnosticsSignError",
  })
  fn.sign_define("LspDiagnosticsSignWarning", {
    texthl = "LspDiagnosticsSignWarning",
    text = lsp_warning,
    numhl = "LspDiagnosticsSignWarning",
  })
  fn.sign_define("LspDiagnosticsSignHint", {
    texthl = "LspDiagnosticsSignHint",
    text = lsp_hint,
    numhl= "LspDiagnosticsSignHint",
  })
  fn.sign_define("LspDiagnosticsSignInformation", {
    texthl = "LspDiagnosticsSignInformation",
    text = lsp_information,
    numhl = "LspDiagnosticsSignInformation",
  })

  lsp.handlers["textDocument/publishDiagnostics"] =
    lsp.with(lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = {
        prefix = lsp_virtual_text, -- change this to whatever you want your diagnostic icons to be
      },
    })
  -- Border for lsp_popups
  lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "single",
  })
  lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "single",
  })
  -- symbols for autocomplete
  lsp.protocol.CompletionItemKind = {
    "   (Text) ",
    "   (Method)",
    "   (Function)",
    "   (Constructor)",
    " ﴲ  (Field)",
    "[] (Variable)",
    "   (Class)",
    " ﰮ  (Interface)",
    "   (Module)",
    " 襁 (Property)",
    "   (Unit)",
    "   (Value)",
    " 練 (Enum)",
    "   (Keyword)",
    "   (Snippet)",
    "   (Color)",
    "   (File)",
    "   (Reference)",
    "   (Folder)",
    "   (EnumMember)",
    " ﲀ  (Constant)",
    " ﳤ  (Struct)",
    "   (Event)",
    "   (Operator)",
    "   (TypeParameter)",
  }

  -- suppress error messages from lang servers
  vim.notify = function(msg, log_level, _opts)
    if msg:match("exit code") then
      return
    end
    if log_level == vim.log.levels.ERROR then
      vim.api.nvim_err_writeln(msg)
    else
      vim.api.nvim_echo({ { msg } }, true, {})
    end
  end


  ----------- [[lsp-keymap]]-------------
  local nvim_lsp = require('lspconfig')
  local utils = require('utils')
  local opts = { noremap=true, silent=true }

  local lsp_keymappings = {
    {'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>'},
    {'gd', '<cmd>lua vim.lsp.buf.definition()<CR>'},
    {'K', '<cmd>lua vim.lsp.buf.hover()<CR>'},
    {'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>'},
    -- TODO: conflict with window jump
    {'<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>'},
    {'<Leader>R', '<cmd>lua vim.lsp.buf.rename()<CR>'},
    {'<Leader>m', '<cmd>lua vim.lsp.buf.code_action()<CR>'},
    {'gr', '<cmd>lua vim.lsp.buf.references()<CR>'},
    {']e', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>'},
    {'[e', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>'},
    -- TODO: vim.lsp.buf.rename()
    -- TODO: <leader>e keep same
    -- TODO: set loclist
    -- buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    -- buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  }

  -- batch set keymap
  for _, map in ipairs(lsp_keymappings) do
    local lhs, rhs = unpack(map)
    utils.nmap(lhs, rhs)
  end

  -- persistent hover when typing
  require "lsp_signature".on_attach()

  -- Use a loop to conveniently call 'setup' on multiple servers and
  -- map buffer local keybindings when the language server attaches
  local servers = { 'pyright', 'tsserver', 'gopls', 'html', 'clangd', 'cmake', 'vuels', 'tailwindcss' }
  for _, lsp_ in ipairs(servers) do
    nvim_lsp[lsp_].setup {
      flags = {
        debounce_text_changes = 150,
      }
    }
  end
end

