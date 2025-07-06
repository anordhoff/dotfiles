local harpoon = require("harpoon")

-- required
harpoon:setup()

-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end

-- keymaps
-- NOTE: deleting an item with 'hr' that isn't at the end of the list breaks telescope
vim.keymap.set("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end)
vim.keymap.set("n", "<leader>hr", function() harpoon:list():remove() end)
vim.keymap.set("n", "<leader>fh", function() toggle_telescope(harpoon:list()) end)
vim.keymap.set("n", "<leader>0", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>4", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>5", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>6", function() harpoon:list():select(4) end)
