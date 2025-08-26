return {
  "lewis6991/hover.nvim",
  config = function()
    require("hover").setup({
      init = function()
        require("hover.providers.lsp")
      end,
      preview_opts = {
        border = "single"
      },
      title = true,
      mouse_providers = {
        "LSP"
      },
      mouse_delay = 1000
    })

    -- Setup keymaps
    vim.keymap.set("n", "K", require("hover").hover, { desc = "Hover" })
    vim.keymap.set("n", "gK", require("hover").hover_select, { desc = "Hover (select)" })
    
    -- Mouse support
    vim.keymap.set("n", "<MouseMove>", require("hover").hover_mouse, { desc = "Hover (mouse)" })
  end
}
