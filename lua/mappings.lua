require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

--comment
map({ "i", "v" }, "<C-_>", "<esc>:CommentToggle<cr>i", { desc = "CommentToggle" })
map({ "n", "v" }, "<C-_>", ":CommentToggle<cr>", { desc = "CommentToggle" })
map({ "v", "v" }, "<C-_>", ":'<,'>CommentToggle<cr>", { desc = "CommentToggle" })

map({ "i", "v" }, "<C-.>", "<esc>:CommentToggle<cr>i", { desc = "CommentToggle" })
map({ "n", "v" }, "<C-.>", ":CommentToggle<cr>", { desc = "CommentToggle" })
map({ "v", "v" }, "<C-.>", ":'<,'>CommentToggle<cr>", { desc = "CommentToggle" })

-- shift navigation slection
if vim.g.neovide == false then
    vim.cmd [[
        highlight Normal guibg=NONE ctermbg=NONE
        highlight NonText guibg=NONE ctermbg=NONE
        highlight LineNr guibg=NONE ctermbg=NONE
        highlight Folded guibg=NONE ctermbg=NONE
        highlight EndOfBuffer guibg=NONE ctermbg=NONE
    ]]
end

if vim.g.neovide == true then
    -- vim.cmd 'set guifont=Hack\ NF:h10'
    -- vim.o.guifont='Consolas:h10'
    -- vim.o.guifont='FiraCode NF:h14'
    --vim.o.guifont='Operator Mono,FiraCode NF:h14'
    local neovideSetup = function()
        -- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
        -- vim.o.guifont = "0xProto Nerd Font Mono:h14"
        vim.g.neovide_refresh_rate = 144
        vim.api.nvim_set_keymap("n", "<C-z>", "", {})
        vim.g.neovide_cursor_smooth_blink = true
        -- transparency mode on
        vim.g.neovide_transparency = 0.6
        vim.g.transparency = 0.6
        vim.g.neovide_floating_blur_amount_x = 0.5
        vim.g.neovide_floating_blur_amount_y = 0.5
        vim.g.neovide_window_blurred = true
        -- radius mvim.g.neovide_floating_shadow = true
        vim.g.neovide_floating_z_height = 10
        vim.g.neovide_light_angle_degrees = 45
        vim.g.neovide_light_radius = 5
        -- contrastt enable
        -- vim.g.neovide_text_gamma = 0.2
        -- vim.g.neovide_text_contrast = 0.2
    end
    neovideSetup()
    vim.api.nvim_set_keymap("n", "<F11>", ":let g:neovide_fullscreen = !g:neovide_fullscreen<CR>", {})
end

function Keypress(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

function Run_current_file()
    local file = vim.fn.expand "%:p"
    local dir = vim.fn.fnamemodify(file, ":h")
    local filetype = vim.bo.filetype
    local cmd = ""
    local fullname = vim.fn.fnamemodify(file, ":t") --without extension file name
    local filename = vim.fn.fnamemodify(file, ":t:r") -- with extension file name
    vim.fn.chdir(dir)
    if filetype == "python" then
        cmd = "python3 " .. fullname
    elseif filetype == "javascript" then
        cmd = "node " .. fullname
    elseif filetype == "typescript" then
        cmd = "ts-node " .. fullname
    elseif filetype == "c" then
        cmd = "gcc " .. fullname .. " -o " .. filename .. ".out" .. " && ./" .. filename .. ".out"
    elseif filetype == "cpp" then
        cmd = "g++ " .. fullname .. " -o " .. filename .. ".out" .. " && ./" .. filename .. ".out"
    elseif filetype == "rust" then
        cmd = "rustc " .. fullname
    elseif filetype == "java" then
        cmd = "javac " .. fullname .. " && java " .. filename
    else
        print("Unsupported filetype: " .. filetype)
        return
    end

    -- vim.fn.setreg('+',cmd)
    -- Keypress(cmd, "i")
    -- Keypress("p", "n")
    -- Keypress("i", "n")
    -- Keypress("<cr>", "i")

    vim.cmd "w"
    vim.cmd("!" .. cmd)
    vim.fn.chdir "-"
end

map(
    { "i", "v" },
    "<F33>",
    "<esc>:lua Run_current_file()<CR>",
    { noremap = true, silent = true, desc = "Excute the program with ctrl+F9 in this F33 refers to ctrl+F9" }
)
map(
    { "n", "v" },
    "<F33>",
    ":lua Run_current_file()<CR>",
    { noremap = true, silent = true, desc = "Excute the program with ctrl+F9 in this F33 refers to ctrl+F9" }
)
map(
    { "i", "v" },
    "<C-F9>",
    "<esc>:lua Run_current_file()<CR>",
    { noremap = true, silent = true, desc = "Excute the program with ctrl+F9 in this F33 refers to ctrl+F9" }
)
map(
    { "n", "v" },
    "<C-F9>",
    ":lua Run_current_file()<CR>",
    { noremap = true, silent = true, desc = "Excute the program with ctrl+F9 in this F33 refers to ctrl+F9" }
)
