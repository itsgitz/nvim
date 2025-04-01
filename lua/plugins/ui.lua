return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    -- add any options here
    presets = {
      -- command_palette = true, -- position the cmdline and popupmenu together
      long_message_to_split = false, -- long messages will be sent to a split
    },
    routes = {
      {
        filter = {
          event = "msg_show",
          min_length = 20,
        },
        view = "split",
      },
    },
  },
  dependencies = {
    -- -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    -- "MunifTanjim/nui.nvim",
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    "rcarriga/nvim-notify",
  },
}
