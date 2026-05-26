local gh = function(x) return "https://github.com/" .. x end
-- local cb = function(x) return "https://codeberg.org/" .. x end

vim.pack.add({
    gh("nvim-lua/plenary.nvim"),
    gh("onsails/lspkind.nvim"),
    gh("nvim-tree/nvim-web-devicons"),
    gh("rafamadriz/friendly-snippets"),
    gh("neovim/nvim-lspconfig"),
    gh("saghen/blink.lib"),
    gh("saghen/blink.cmp"),
    gh("romus204/tree-sitter-manager.nvim"),
    gh("nvim-mini/mini.pairs"),
    { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
    gh("ibhagwan/fzf-lua"),
    gh("stevearc/conform.nvim"),
    gh("lewis6991/gitsigns.nvim"),
    { src = gh("ThePrimeagen/harpoon"), version = "harpoon2" },
    gh("MeanderingProgrammer/render-markdown.nvim"),
    gh("jakewvincent/mkdnflow.nvim"),
    gh("nvim-pack/nvim-spectre"),
    gh("folke/trouble.nvim"),
    gh("mrjones2014/smart-splits.nvim"),
})

require("catppuccin").setup({
    compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
    flavour = "mocha",
    term_colors = true,
    styles = {
        comments = { "italic" }, -- Keep italic for visual distinction
        conditionals = { "bold" }, -- Make if/else/switch stand out
        loops = { "bold" }, -- Make for/while/repeat prominent
        functions = { "bold" }, -- Function names easier to spot
        keywords = { "bold" }, -- Language keywords more visible
        strings = {}, -- Keep normal for readability
        variables = {}, -- Keep normal to avoid clutter
        numbers = { "bold" }, -- Make constants stand out
        booleans = { "bold" }, -- true/false more prominent
        properties = { "italic" }, -- Object properties slightly emphasized
        types = { "bold" }, -- Data types more visible
        operators = {}, -- Keep normal to avoid visual noise
    },
    default_integrations = false,
    auto_integrations = true,
    integrations = {
        native_lsp = {
            enabled = true,
            virtual_text = {
                errors = { "italic" },
                hints = { "italic" },
                warnings = { "italic" },
                information = { "italic" },
                ok = { "italic" },
            },
            underlines = {
                errors = { "underline" },
                hints = { "underline" },
                warnings = { "underline" },
                information = { "underline" },
                ok = { "underline" },
            },
            inlay_hints = {
                background = true,
            },
        },
    },
})
vim.cmd.colorscheme("catppuccin-nvim")

require("mini.pairs").setup()
require("nvim-web-devicons").setup({})

-- LSP

vim.lsp.config("lua_ls", {
    on_init = function(client)
        if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if
                path ~= vim.fn.stdpath("config")
                and (
                    vim.uv.fs_stat(path .. "/.luarc.json")
                    or vim.uv.fs_stat(path .. "/.luarc.jsonc")
                )
            then
                return
            end
        end

        client.config.settings.Lua =
            vim.tbl_deep_extend("force", client.config.settings.Lua, {
                runtime = {
                    version = "LuaJIT",
                    path = {
                        "lua/?.lua",
                        "lua/?/init.lua",
                    },
                },
                workspace = {
                    checkThirdParty = false,
                    library = {
                        vim.env.VIMRUNTIME,
                    },
                },
            })
    end,
    settings = {
        Lua = {},
    },
})
vim.lsp.enable("lua_ls")
vim.lsp.enable("fish_lsp")

-- blink.cmp

local cmp = require("blink.cmp")
cmp.build():wait(60000)
cmp.setup({
    keymap = { preset = "enter" },
    sources = { default = { "lsp", "path", "snippets", "buffer" } },
    completion = {
        accept = { auto_brackets = { enabled = true } },
        documentation = { auto_show = true, auto_show_delay_ms = 200 },
        menu = {
            draw = {
                components = {
                    kind_icon = {
                        text = function(ctx)
                            local icon = ctx.kind_icon
                            if vim.tbl_contains({ "Path" }, ctx.source_name) then
                                local dev_icon, _ =
                                    require("nvim-web-devicons").get_icon(ctx.label)
                                if dev_icon then icon = dev_icon end
                            else
                                icon = require("lspkind").symbolic(ctx.kind, {
                                    mode = "symbol",
                                })
                            end
                            return icon .. ctx.icon_gap
                        end,
                        highlight = function(ctx)
                            local hl = ctx.kind_hl
                            if vim.tbl_contains({ "Path" }, ctx.source_name) then
                                local dev_icon, dev_hl =
                                    require("nvim-web-devicons").get_icon(ctx.label)
                                if dev_icon then hl = dev_hl end
                            end
                            return hl
                        end,
                    },
                },
            },
        },
    },
    cmdline = {
        keymap = {
            preset = "inherit",
            ["<Tab>"] = { "show", "accept" },
            ["<CR>"] = {},
        },
        completion = {
            menu = { auto_show = true },
            ghost_text = { enabled = true },
        },
    },
    fuzzy = { implementation = "rust" },
})

-- treesitter

require("tree-sitter-manager").setup({
    ensure_installed = {
        "bash",
        "c",
        "diff",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "printf",
        "python",
        "query",
        "regex",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
        "go",
    },
    auto_install = true,
})

-- fzf-lua

require("fzf-lua").setup({
    "border-fused",
    winopts = {
        preview = {
            horizontal = "right:75%",
        },
    },
})
require("fzf-lua").register_ui_select()

-- conform

require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        markdown = { "prettier" },
        fish = { "fish_indent" },
        python = { "ruff" },
        json = { "prettier" },
    },
    default_format_opts = {
        lsp_format = "fallback",
        async = true,
    },
})

-- gitsigns

require("gitsigns").setup({
    signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
    },
    signs_staged = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
    },
})

-- harpoon
local harpoon = require("harpoon")
harpoon:setup({
    settings = {
        save_on_toggle = true,
        sync_on_ui_close = true,
    },
})

-- render-markdown

require("render-markdown").setup({
    latex = { enabled = false },
    file_types = { "markdown", "copilot-chat" },
    pipe_table = {
        preset = "round",
        min_width = 15,
    },
    completions = { lsp = { enabled = true }, blink = { enabled = true } },
    render_modes = true,
    checkbox = {
        enabled = true,
        render_modes = false,
        bullet = false,
        right_pad = 1,
        unchecked = {
            icon = "󰄱 ",
            highlight = "RenderMarkdownUnchecked",
            scope_highlight = nil,
        },
        checked = {
            icon = "󰱒 ",
            highlight = "RenderMarkdownChecked",
            scope_highlight = "@markup.strikethrough",
        },
        custom = {
            todo = {
                raw = "[/]",
                rendered = "󰥔 ",
                highlight = "RenderMarkdownTodo",
                scope_highlight = nil,
            },
        },
    },
})

-- mkdnflow

require("mkdnflow").setup({
    perspective = {
        priority = "root",
        root_tell = "start_page.md",
    },
    links = {
        style = "markdown",
        transform_explicit = function(text)
            text = text:gsub(" ", "-")
            text = text:lower()
            return text
        end,
    },
    to_do = {
        highlight = false,
        statuses = {
            not_started = { marker = " ", ... },
            in_progress = { marker = "-", ... },
            complete = { marker = { "X", "x" }, ... },
        },
        status_order = { "not_started", "in_progress", "complete" },
        status_propagation = { up = true, down = true },
        sort = {
            on_status_change = false,
            recursive = false,
            cursor_behavior = { track = true },
        },
    },
    tables = {
        trim_whitespace = true,
        format_on_move = true,
        style = {
            cell_padding = 1,
            separator_padding = 1,
            outer_pipes = true,
            mimic_alignment = true,
        },
    },
    mappings = {
        MkdnFoldSection = false,
        MkdnUnfoldSection = false,
    },
})

-- trouble

require("trouble").setup({
    focus = true,
})
