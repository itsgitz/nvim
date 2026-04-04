return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    -- Disable didChangeWatchedFiles dynamic registration to prevent redundant file watchers
    opts.capabilities = opts.capabilities or {}
    opts.capabilities.workspace = opts.capabilities.workspace or {}
    opts.capabilities.workspace.didChangeWatchedFiles = opts.capabilities.workspace.didChangeWatchedFiles or {}
    opts.capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false

    return opts
  end,
  init = function()
    local lsp = vim.lsp
    local diagnostic = vim.diagnostic

    -- Debounce publishDiagnostics to prevent constant redraws during rapid typing
    local publish_queue = {}
    local publish_timer = nil
    local debounce_delay = 300

    local original_on_publish = lsp.handlers["textDocument/publishDiagnostics"]
    lsp.handlers["textDocument/publishDiagnostics"] = vim.schedule_wrap(function(err, result, ctx, config)
      local bufnr = result.uri and vim.fn.bufloaded(vim.uri_to_bufnr(result.uri)) and vim.uri_to_bufnr(result.uri) or nil

      if not bufnr then
        return original_on_publish(err, result, ctx, config)
      end

      -- Queue the result
      publish_queue[bufnr] = { err, result, ctx, config }

      -- Clear existing timer and set a new one
      if publish_timer then
        vim.fn.timer_stop(publish_timer)
      end

      publish_timer = vim.fn.timer_start(debounce_delay, function()
        for buf, diag_result in pairs(publish_queue) do
          original_on_publish(diag_result[1], diag_result[2], diag_result[3], diag_result[4])
        end
        publish_queue = {}
        publish_timer = nil
      end)
    end)
  end,
}
