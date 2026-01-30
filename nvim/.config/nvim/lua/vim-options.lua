vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
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
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")
-- vim.keymap.set("n", "<leader>q", ":q<CR>")
vim.keymap.set("n", "<leader>Q", ":q!<CR>")
vim.keymap.set("n", "<leader>bd", ":bd<CR>")
vim.keymap.set({"n", "v"}, "<leader>yy", '"+y<CR>')
vim.keymap.set("n", "<leader>pp", '"+p<CR>')
vim.keymap.set("n", "<leader>wa", ":wa<CR>")

-- break line in normal models
vim.keymap.set("n", "<leader>o", "a<CR><Esc>k$")
vim.keymap.set("n", "<leader>O", "i<CR><Esc>k$")
vim.keymap.set("n", "<leader>v", ":vsplit<CR>")

vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>")
vim.keymap.set("n", "<leader>;", ":lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>")
vim.wo.number = true

