local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

configs.setup {
  ensure_installed = "maintained",
  sync_install = false,
  ignore_install = { "" },

  autopairs = {
      enable = true,
  },

--  autotag = {
--    enable = true,
--    filetypes = { "html", "xml", "javascriptreact", "typescriptreact", "svelte", "vue" },
--    skip_tags = {
--      "area", "base", "br", "col", "command", "embed", "hr", "img", "slot",
--      "input", "keygen", "link", "meta", "param", "source", "track", "wbr", "menuitem"
--    }
--  },

  highlight = {
    enable = true,
    disable = { "" },
    additional_vim_regex_highlighting = true,
  },
  indent = { enable = true, disable = { "yaml" } },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
}
