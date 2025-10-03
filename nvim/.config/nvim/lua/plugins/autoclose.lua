-- return {
--   "m4xshen/autoclose.nvim",
--   config = function ()
--     require("autoclose").setup({});
--   end
-- }
return {
  'windwp/nvim-autopairs',
  config = function()
    require('nvim-autopairs').setup()
  end
}
