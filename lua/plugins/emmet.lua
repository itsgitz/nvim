return {
  "mattn/emmet-vim",
  ft = {
    "html",
    "css",
    "javascript",
    "javascriptreact",
    "typescriptreact",
    "vue",
    "php",
    "blade",
    "svelte",
    "smarty",
    "tpl",
  },
  init = function()
    vim.g.user_emmet_leader_key = "<C-e>" -- Change this if you want a different trigger
    vim.g.user_emmet_settings = {
      html = {
        snippets = {
          ["html:5"] = '<!DOCTYPE html><html lang="en"><head><meta charset="UTF-8"><title></title></head><body></body></html>',
        },
      },
    }
  end,
}
