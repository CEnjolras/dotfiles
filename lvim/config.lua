lvim.plugins = {
  { "lunarvim/colorschemes" },
  {  "ray-x/lsp_signature.nvim" },
  {
    'rmagatti/auto-session',
    config = function()
      require("auto-session").setup {
        log_level = "error",
        auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/"},
      }
    end
  },
  {
    'nmac427/guess-indent.nvim',
    config = function() require('guess-indent').setup {} end,
  }
}

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
    pattern = '*',
    callback = function() vim.highlight.on_yank({timeout=350, higroup='Visual'}) end
})


