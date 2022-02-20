vim.cmd('noremap <leader><space> :nohl<cr>:call clearmatches()<cr>') -- clear matches Ctrl+b

function map(mode, shortcut, command)
 vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function nmap(shortcut, command)
  map('n', shortcut, command)
end

function imap(shortcut, command)
  map('i', shortcut, command)
end

function vmap(shortcut, command)
  map('v', shortcut, command)
end

function cmap(shortcut, command)
  map('c', shortcut, command)
end

function tmap(shortcut, command)
  map('t', shortcut, command)
end

-- sane regexes
nmap('/', '/\\v')
vmap('/', '/\\v')

-- don't jump when using *
nmap('*', '*<c-o>')

-- more convenient and not use ; normally
nmap(';', ':')
imap('kj', '<ESC>')

-- keep search matches in the middle of the window
nmap('n', 'nzzzv')
nmap('N', 'Nzzzv')

-- Same when jumpig around
--nmap('g;', 'g;zz')

-- Open a Quickfix window for the last search.
nmap("<leader>.", ":execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>")

-- more natural movement with wrap on
nmap('j', 'gj')
nmap('k', 'gk')
vmap('j', 'gj')
vmap('k', 'gk')

-- Easy buffer navigation
nmap('<C-h>', '<C-w>h')
nmap('<C-j>', '<C-w>j')
nmap('<C-k>', '<C-w>k')
nmap('<C-l>', '<C-w>l')

-- Reselect visual block after indent/outdent
vmap('<', '<gv')
vmap('>', '>gv')

-- home and end line in command mode
cmap('<C-a>', '<Home>')
cmap('<C-e>', '<End>')
nmap('<C-a>', '<Home>')
nmap('<C-e>', '<End>')
imap('<C-a>', '<Home>')
imap('<C-e>', '<End>')
nmap('<C-f>', '<Right>')
nmap('<C-b>', '<Left>')
imap('<C-f>', '<Right>')
imap('<C-b>', '<Left>')
vmap('<C-f>', '<Right>')
vmap('<C-b>', '<Left>')

-- Buffer movement
nmap('[b', '<cmd>bprev<CR>')
nmap(']b', '<cmd>bnext<CR>')

-- Tab movement
nmap('[t', '<cmd>bprev<CR>')
nmap(']t', '<cmd>bnext<CR>')



-- Terminal
-- ESC to go to normal mode in terminal
tmap('<C-s>', '<C-\\><C-n>')
tmap('<Esc><Esc>', '<C-\\><C-n>')

-- Easy window split; C-w v -> vv, C-w - s -> ss
-- nmap('vv', '<C-w>v')
-- nmap('ss', '<C-w>s')
vim.o.splitbelow = true -- when splitting horizontally, move coursor to lower pane
vim.o.splitright = true -- when splitting vertically, mnove coursor to right pane

------------[[MOST COMMEN USED KEYMAP]]------------

-- Find files using Fzf command-line sugar.
-- files in the git project.
nmap('<Leader>f', '<cmd>FzfLua git_files<CR>')
-- files in the current directory
nmap("<localleader>f", "<cmd>FzfLua files<CR>")
-- recent files
nmap("<Leader>r", "<cmd>FzfLua oldfiles<CR>")
-- global quickfix
nmap("<Leader>q", "<cmd>FzfLua quickfix<CR>")
-- all commands from built-in and plugins in vim
nmap("<Leader>;", "<cmd>FzfLua commands<CR>")
-- commands excute history
nmap("<Leader>/", "<cmd>FzfLua command_history<CR>")
-- search history
nmap("<Leader>.", "<cmd>FzfLua search_history<CR>")
-- lines, blines, grep_curbuf, grep_project, live_grep ?
nmap("<Leader>l", "<cmd>FzfLua blines<CR>")
-- rg grep
nmap("<Leader>s", "<cmd>FzfLua grep<CR>")

-- git commit log buffer
nmap('<localleader>l', '<cmd>FzfLua git_bcommits<CR>')
-- symbols from ctags in the project
nmap('<Leader>t', '<cmd>FzfLua tags<CR>')
-- symbols from current file
nmap('<Leader>i', '<cmd>FzfLua btags<CR>')
-- help tags from vim and plugins doc
nmap('<Leader>h', '<cmd>FzfLua help_tags<CR>')
-- marks?
nmap('<Leader>m', '<cmd>FzfLua marks<CR>')


-- Git
-- setup mapping to call :LazyGit, gitflow
nmap('<Leader>g', '<cmd>LazyGit<CR>')

-- Ranger
nmap('<Leader>d', '<cmd>Ranger<CR>')


-- Zen Mode
nmap("<Leader>k", "<cmd>ZenMode<CR>")


-- LSP
--nmap('K', '<cmd>Lspsaga hover_doc<cr>')
--imap('<C-k>', '<cmd>Lspsaga hover_doc<cr>')
--nmap('gh', '<cmd>Lspsaga lsp_finder<cr>')
--nmap('<C-e>', '<cmd>Lspsaga show_line_diagnostics<CR>')

-- Comments
-- NOTE: This keymap would be conflict with iterm2(find cursor).
-- TODO: not valid, ctrl-/
nmap('<leader><CR>', '<cmd>Commentary<CR><down>')
vmap('<leader><CR>', '<cmd>Commentary<CR><down>')

