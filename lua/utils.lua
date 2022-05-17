local M = {}


function map(mode, shortcut, command)
 vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function M.buf_nmap(shortcut, command)
  buf_map('n', shortcut, command)
end

function M.nmap(shortcut, command)
  map('n', shortcut, command)
end

function M.imap(shortcut, command)
  map('i', shortcut, command)
end

function M.vmap(shortcut, command)
  map('v', shortcut, command)
end

function M.cmap(shortcut, command)
  map('c', shortcut, command)
end

function M.tmap(shortcut, command)
  map('t', shortcut, command)
end

return M
