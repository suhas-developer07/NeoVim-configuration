return {
  "ray-x/lsp_signature.nvim",
  event = "VeryLazy",
  config = function()
    require("lsp_signature").setup({
      bind = true,
      handler_opts = {
        border = "rounded"
      },
      hint_enable = true,
      hint_prefix = "💡 ",
      hint_scheme = "String",
      hi_parameter = "LspSignatureActiveParameter",
      max_height = 12,
      max_width = 80,
      transparency = 10,
    })
  end,
}
