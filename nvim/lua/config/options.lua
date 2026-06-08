local opt = vim.opt

opt.number = true
opt.fillchars = { eob = " " }

-- Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true

-- UI
opt.termguicolors = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.scrolloff = 4

-- Search
opt.ignorecase = true
opt.smartcase = true

-- System clipboard
opt.clipboard = "unnamedplus"

-- Swap and backup
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.undodir = os.getenv("HOME") .. "/.local/state/nvim/undo"

-- Time for mapped sequences
opt.timeoutlen = 300

-- Always Open Second buffer on right.  
opt.splitright = true
