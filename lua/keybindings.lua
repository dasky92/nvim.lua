vim.cmd('noremap <leader><space> :nohl<cr>:call clearmatches()<cr>') -- clear matches Ctrl+b

local nmap = require('utils').nmap
local imap = require('utils').imap
local vmap = require('utils').vmap
local cmap = require('utils').cmap
local tmap = require('utils').tmap

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

-- Find files under current directory.
nmap('<Leader>f', '<cmd>Telescope find_files<CR>')
-- Find files in the git project.
nmap('<Localleader>f', '<cmd>Telescope git_files<CR>')
nmap('<Leader>b', '<cmd>Telescope buffers')
-- files in the current directory
--nmap("<localleader>f", "<cmd>FzfLua files<CR>")
-- recent files
nmap("<Leader>r", "<cmd>Telescope oldfiles<CR>")
-- global quickfix
nmap("<Leader>q", "<cmd>Telescope quickfix<CR>")
nmap("<Leader>Q", "<cmd>Telescope quickfixhistory<CR>")
-- all commands from built-in and plugins in vim
nmap("<Leader>;", "<cmd>Telescope commands<CR>")
-- commands excute history
nmap("<Leader>.", "<cmd>Telescope command_history<CR>")
-- search history
nmap("<Leader>/", "<cmd>Telescope search_history<CR>")
-- rg grep
nmap("<Leader>s", "<cmd>Telescope live_grep<CR>")

-- git commit log buffer
nmap('<localleader>gl', '<cmd>Telescope git_bcommits<CR>')
nmap('<localleader>gb', '<cmd>Telescope git_branches<CR>')
nmap('<localleader>gs', '<cmd>Telescope git_status<CR>')
nmap('<localleader>gS', '<cmd>Telescope git_stash<CR>')
-- symbols from ctags in the project or current directory ?TODO:
nmap('<Leader>I', '<cmd>Telescope tags<CR>')
-- symbols from current file
nmap('<Leader>i', '<cmd>Telescope current_buffer_tags<CR>')
-- help tags from vim and plugins doc
nmap('<Leader>h', '<cmd>Telescope help_tags<CR>')
-- outline
nmap('<Leader>a', '<cmd>AerialToggle!<CR>')


-- Git
-- setup mapping to call :LazyGit, gitflow
nmap('<Leader>g', '<cmd>LazyGit<CR>')

-- Ranger
nmap('<Leader>d', '<cmd>Ranger<CR>')


-- Zen Mode
nmap("<Leader>k", "<cmd>ZenMode<CR>")

-- colorscheme
nmap('<Leader>t', '<cmd>Telescope colorscheme<CR>')

-- Dictionary
nmap('D', '<Plug>TranslateW')
vmap('D', '<Plug>TranslateWV')
nmap('T', '<cmd>TranslateW --target_lang=en --source_lang=zh <CR>')
nmap('T', '<ESC><cmd>TranslateW --target_lang=en --source_lang=zh <CR>')


-- LSP
-- TODO: use telescope built-in functions
-- Use lspconfig keybind at first.
nmap('<Localleader>lr', '<cmd>Telescope lsp_references<CR>')
nmap('<Localleader>le', '<cmd>Telescope diagnostics<CR>')
nmap('<Localleader>ld', '<cmd>Telescope lsp_definitions<CR>')
nmap('<Localleader>li', '<cmd>Telescope lsp_implementations<CR>')
--nmap('<C-e>', '<cmd>Lspsaga show_line_diagnostics<CR>')

-- Comments
-- NOTE: This keymap would be conflict with iterm2(find cursor).
-- TODO: not valid, ctrl-/
nmap('<leader><CR>', '<cmd>Commentary<CR><down>')
vmap('<leader><CR>', '<cmd>Commentary<CR><down>')
