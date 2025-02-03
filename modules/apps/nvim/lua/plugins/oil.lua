require("oil").setup({
    default_file_explorer = true,
    columns = {
        "icon",
    },
})
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
