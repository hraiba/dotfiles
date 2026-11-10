vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set cursorline")
vim.cmd("set ignorecase")
-- make sure you have one of these clipboard providers installed:
-- xclip for X11
-- wl-clipboard for Wayland
-- xsel
vim.cmd("set clipboard+=unnamedplus")

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
	end,
})

vim.g.mapleader = " "
vim.g.background = "dark"

vim.opt.swapfile = false

-- Navigate vim panes better
vim.keymap.set("n", "<c-k>", "<cmd>wincmd k<CR>")
vim.keymap.set("n", "<c-j>", "<cmd>wincmd j<CR>")
vim.keymap.set("n", "<c-h>", "<cmd>wincmd h<CR>")
vim.keymap.set("n", "<c-l>", "<cmd>wincmd l<CR>")
-- vim.keymap.set("n", "<leader>q", ":q<CR>")
vim.keymap.set("n", "<leader>Q", "<cmd>q!<CR>")
vim.keymap.set("n", "<leader>bd", "<cmd>bd<CR>")
vim.keymap.set({"n", "v"}, "<leader>yy", '"+y<CR>')
vim.keymap.set("n", "<leader>pp", '"+p<CR>')
vim.keymap.set("n", "<leader>wa", "<cmd>wa<CR>")

-- break line in normal models
vim.keymap.set("n", "<leader>o", "a<CR><Esc>k$")
vim.keymap.set("n", "<leader>O", "i<CR><Esc>k$")
vim.keymap.set("n", "<leader>v", "<cmd>vsplit<CR>")

vim.keymap.set("n", "<leader>h", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>;", "<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>")
vim.wo.number = true
vim.wo.signcolumn = "yes:2"

-- Enable bracket pair matching and highlighting
vim.o.showmatch = true  -- Show matching bracket
vim.o.matchtime = 2     -- Tenths of a second to show matching bracket
vim.cmd([[
  highlight MatchParen cterm=bold gui=bold guibg=#3e4451 guifg=NONE
]])

