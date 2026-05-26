local map = vim.keymap.set

-- Editor Basics

map("n", "<C-b>", "<C-v>", { noremap = true, desc = "Visual block mode" })

map("n", "<S-down>", "<C-d>zz", { desc = "Scroll down half and center" })
map("n", "<S-up>", "<C-u>zz", { desc = "Scroll up half and center" })

map(
    "n",
    "<C-S-down>",
    "<cmd>execute 'move .+' . v:count1<cr>==",
    { desc = "Move line down", silent = true }
)
map(
    "n",
    "<C-S-up>",
    "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==",
    { desc = "Move line up", silent = true }
)
map(
    "i",
    "<C-S-down>",
    "<esc><cmd>m .+1<cr>==gi",
    { desc = "Move line down", silent = true }
)
map("i", "<C-S-up>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move line up", silent = true })
map(
    "v",
    "<C-S-down>",
    ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv",
    { desc = "Move selection down", silent = true }
)
map(
    "v",
    "<C-S-up>",
    ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv",
    { desc = "Move selection up", silent = true }
)

map("v", "<", "<gv", { desc = "Indent left and reselect" })
map("v", ">", ">gv", { desc = "Indent right and reselect" })

map("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keyword program" })

-- Search

map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

map(
    "n",
    "<leader>ur",
    "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
    { desc = "Redraw / clear hlsearch / diff update" }
)

map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Text Operations

map(
    "x",
    "p",
    'p:let @+=@0<CR>:let @"=@0<CR>',
    { noremap = true, silent = true, desc = "Paste without clobbering" }
)

map(
    "v",
    "<leader>rv",
    '"hy:%s/\\V<C-r>h/<C-r>h/gc<left><left><left>',
    { desc = "Replace visual selection" }
)
map(
    "n",
    "<leader>rw",
    [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "Replace word under cursor" }
)

-- Windows

map("n", "<C-v>", "<C-w>v", { desc = "Split window right" })
map("n", "<C-s>", "<C-w>s", { desc = "Split window below" })
map("n", "<C-c>", "<C-w>c", { desc = "Close current window" })
map("n", "<C-f>", "<C-w><C-w>", { desc = "Cycle windows" })

-- Tabs & Buffers

map("n", "<C-a>", ":$tabnew<CR>", { noremap = true, silent = true, desc = "New tab" })
map("n", "<C-q>", ":tabclose<CR>", { noremap = true, silent = true, desc = "Close tab" })
map(
    "n",
    "<leader>to",
    ":tabonly<CR>",
    { noremap = true, silent = true, desc = "Close other tabs" }
)
map("n", "<C-.>", ":tabn<CR>", { noremap = true, silent = true, desc = "Next tab" })
map("n", "<C-,>", ":tabp<CR>", { noremap = true, silent = true, desc = "Prev tab" })
map(
    "n",
    "<C-S-,>",
    ":-tabmove<CR>",
    { noremap = true, silent = true, desc = "Move tab left" }
)
map(
    "n",
    "<C-S-.>",
    ":+tabmove<CR>",
    { noremap = true, silent = true, desc = "Move tab right" }
)
map(
    "n",
    "<C-Tab>",
    ":bp<cr>zz",
    { noremap = true, silent = true, desc = "Previous buffer" }
)
map(
    "n",
    "<C-S-Tab>",
    ":bn<cr>zz",
    { noremap = true, silent = true, desc = "Next buffer" }
)
map(
    "n",
    "<leader>bd",
    ":bd<cr>",
    { noremap = true, silent = true, desc = "Delete buffer" }
)

-- Terminal

map("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

-- Formatting

map("n", "<leader>w", function()
    require("conform").format()
    vim.cmd("w")
end, { noremap = true, silent = true, desc = "Format and save" })

map(
    "n",
    "<leader>f",
    function() require("conform").format() end,
    { desc = "Format buffer" }
)

-- fzf-lua

map(
    "n",
    "<A-o>",
    function() require("fzf-lua").files({ hidden = false }) end,
    { desc = "Find files" }
)
map(
    "n",
    "<A-S-o>",
    function() require("fzf-lua").files({ hidden = true }) end,
    { desc = "Find files (hidden)" }
)
map(
    "n",
    "<leader>s",
    function() require("fzf-lua").lsp_document_symbols() end,
    { desc = "Document symbols" }
)
map(
    "n",
    "<leader>S",
    function() require("fzf-lua").lsp_workspace_symbols() end,
    { desc = "Workspace symbols" }
)
map("n", "<A-b>", function() require("fzf-lua").buffers() end, { desc = "Buffers" })
map("n", "<A-g>", function() require("fzf-lua").live_grep() end, { desc = "Live grep" })
map(
    "n",
    "<leader>dd",
    function() require("fzf-lua").diagnostics_document() end,
    { desc = "Document diagnostics" }
)
map(
    "n",
    "<leader>dw",
    function() require("fzf-lua").diagnostics_workspace() end,
    { desc = "Workspace diagnostics" }
)
map("n", "<S-z>", function() require("fzf-lua").zoxide() end, { desc = "Zoxide" })
map("n", "<A-r>", function() require("fzf-lua").oldfiles() end, { desc = "Recent files" })
map(
    "n",
    "gr",
    function() require("fzf-lua").lsp_references() end,
    { desc = "References" }
)
map(
    "n",
    "gd",
    function() require("fzf-lua").lsp_definitions() end,
    { desc = "Goto definition" }
)
map(
    "n",
    "<leader>*",
    function() require("fzf-lua").grep_cword() end,
    { desc = "Grep word under cursor" }
)
map(
    "n",
    "<leader>/",
    function() require("fzf-lua").blines() end,
    { desc = "Buffer lines" }
)
map(
    "n",
    "<leader>gs",
    function() require("fzf-lua").git_status() end,
    { desc = "Git status" }
)
map(
    "n",
    "<leader>gc",
    function() require("fzf-lua").git_commits() end,
    { desc = "Git commits" }
)
map("n", "<leader>fk", function() require("fzf-lua").keymaps() end, { desc = "Keymaps" })
map(
    "n",
    "<leader>fh",
    function() require("fzf-lua").help_tags() end,
    { desc = "Help tags" }
)

-- gitsigns

map("n", "]h", function()
    if vim.wo.diff then
        vim.cmd.normal({ "]c", bang = true })
    else
        require("gitsigns").nav_hunk("next")
    end
end, { desc = "Next hunk" })
map("n", "[h", function()
    if vim.wo.diff then
        vim.cmd.normal({ "[c", bang = true })
    else
        require("gitsigns").nav_hunk("prev")
    end
end, { desc = "Prev hunk" })
map(
    "n",
    "]H",
    function() require("gitsigns").nav_hunk("last") end,
    { desc = "Last hunk" }
)
map(
    "n",
    "[H",
    function() require("gitsigns").nav_hunk("first") end,
    { desc = "First hunk" }
)
map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", { desc = "Stage hunk" })
map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", { desc = "Reset hunk" })
map("n", "<leader>ghS", require("gitsigns").stage_buffer, { desc = "Stage buffer" })
map("n", "<leader>ghu", require("gitsigns").undo_stage_hunk, { desc = "Undo stage hunk" })
map("n", "<leader>ghR", require("gitsigns").reset_buffer, { desc = "Reset buffer" })
map(
    "n",
    "<leader>ghp",
    function() require("gitsigns").preview_hunk_inline() end,
    { desc = "Preview hunk" }
)
map(
    "n",
    "<leader>ghb",
    function() require("gitsigns").blame_line({ full = true }) end,
    { desc = "Blame line" }
)
map(
    "n",
    "<leader>ghB",
    function() require("gitsigns").blame() end,
    { desc = "Blame buffer" }
)
map("n", "<leader>ghd", require("gitsigns").diffthis, { desc = "Diff this" })
map(
    "n",
    "<leader>ghD",
    function() require("gitsigns").diffthis("~") end,
    { desc = "Diff this ~" }
)
map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select hunk" })

-- harpoon

map(
    "n",
    "<leader>a",
    function() require("harpoon"):list():add() end,
    { desc = "Add to harpoon" }
)
map(
    "n",
    "<A-;>",
    function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end,
    { desc = "Harpoon menu" }
)
map(
    "n",
    "<A-h>",
    function() require("harpoon"):list():select(1) end,
    { desc = "Harpoon file 1" }
)
map(
    "n",
    "<A-t>",
    function() require("harpoon"):list():select(2) end,
    { desc = "Harpoon file 2" }
)
map(
    "n",
    "<A-n>",
    function() require("harpoon"):list():select(3) end,
    { desc = "Harpoon file 3" }
)
map(
    "n",
    "<A-s>",
    function() require("harpoon"):list():select(4) end,
    { desc = "Harpoon file 4" }
)

-- spectre

map("n", "gs", '<cmd>lua require("spectre").toggle()<CR>', { desc = "Toggle Spectre" })
map(
    "n",
    "<leader>sw",
    '<cmd>lua require("spectre").open_visual({select_word=true})<CR>',
    { desc = "Search word" }
)
map(
    "v",
    "<leader>sw",
    '<esc><cmd>lua require("spectre").open_visual()<CR>',
    { desc = "Search visual selection" }
)
map(
    "n",
    "<leader>sp",
    '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
    { desc = "Search file" }
)

-- trouble

map(
    "n",
    "<leader>xx",
    "<cmd>Trouble diagnostics toggle<cr>",
    { desc = "Diagnostics (Trouble)" }
)
map(
    "n",
    "<leader>xX",
    "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
    { desc = "Buffer diagnostics (Trouble)" }
)
map(
    "n",
    "<leader>cs",
    "<cmd>Trouble symbols toggle focus=false<cr>",
    { desc = "Symbols (Trouble)" }
)
map(
    "n",
    "<leader>cl",
    "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
    { desc = "LSP references (Trouble)" }
)
map(
    "n",
    "<leader>xL",
    "<cmd>Trouble loclist toggle<cr>",
    { desc = "Location list (Trouble)" }
)
map(
    "n",
    "<leader>xQ",
    "<cmd>Trouble qflist toggle<cr>",
    { desc = "Quickfix list (Trouble)" }
)
map("n", "[q", function()
    if require("trouble").is_open() then
        require("trouble").prev({ skip_groups = true, jump = true })
    else
        local ok, err = pcall(vim.cmd.cprev)
        if not ok then vim.notify(err, vim.log.levels.ERROR) end
    end
end, { desc = "Previous trouble/quickfix item" })
map("n", "]q", function()
    if require("trouble").is_open() then
        require("trouble").next({ skip_groups = true, jump = true })
    else
        local ok, err = pcall(vim.cmd.cnext)
        if not ok then vim.notify(err, vim.log.levels.ERROR) end
    end
end, { desc = "Next trouble/quickfix item" })

-- smart-splits

-- Resize
map(
    "n",
    "<A-Left>",
    function() require("smart-splits").resize_left() end,
    { desc = "Resize left" }
)
map(
    "n",
    "<A-Down>",
    function() require("smart-splits").resize_down() end,
    { desc = "Resize down" }
)
map(
    "n",
    "<A-Up>",
    function() require("smart-splits").resize_up() end,
    { desc = "Resize up" }
)
map(
    "n",
    "<A-Right>",
    function() require("smart-splits").resize_right() end,
    { desc = "Resize right" }
)

-- Move cursor between splits
map(
    "n",
    "<C-Left>",
    function() require("smart-splits").move_cursor_left() end,
    { desc = "Move to left split" }
)
map(
    "n",
    "<C-Down>",
    function() require("smart-splits").move_cursor_down() end,
    { desc = "Move to below split" }
)
map(
    "n",
    "<C-Up>",
    function() require("smart-splits").move_cursor_up() end,
    { desc = "Move to above split" }
)
map(
    "n",
    "<C-Right>",
    function() require("smart-splits").move_cursor_right() end,
    { desc = "Move to right split" }
)
map(
    "n",
    "<C-\\>",
    function() require("smart-splits").move_cursor_previous() end,
    { desc = "Move to previous split" }
)

-- Swap buffers between windows
map(
    "n",
    "<leader><leader>Left",
    function() require("smart-splits").swap_buf_right() end,
    { desc = "Swap buffer right" }
)
map(
    "n",
    "<leader><leader>Down",
    function() require("smart-splits").swap_buf_down() end,
    { desc = "Swap buffer down" }
)
map(
    "n",
    "<leader><leader>Up",
    function() require("smart-splits").swap_buf_up() end,
    { desc = "Swap buffer up" }
)
map(
    "n",
    "<leader><leader>Right",
    function() require("smart-splits").swap_buf_left() end,
    { desc = "Swap buffer left" }
)
