local function cleanup_term_string(s)
  return s:gsub('\r', ''):gsub('\x1b%[[%d;]*m', '')
end

local bufenter_callbacks = {}
local set_bufenter_callback = function(bufnr, key, callback)
  local cbs = bufenter_callbacks[bufnr]
  if not cbs then
    cbs = {}
    bufenter_callbacks[bufnr] = cbs
  end
  if cbs[key] then
    vim.api.nvim_del_autocmd(cbs[key])
  end
  cbs[key] = vim.api.nvim_create_autocmd("BufEnter", {
    desc = "set diagnostics on first enter",
    callback = function()
      cbs[key] = nil
      if vim.tbl_isempty(bufenter_callbacks[bufnr]) then
        bufenter_callbacks[bufnr] = nil
      end
      callback(bufnr)
    end,
    buffer = bufnr,
    once = true,
    nested = true,
  })
end

local function find_matches(output, regex)
  local matches = {}
  for line in output:gmatch("[^\r\n]+") do
    local filename, lineno, type, message = line:match(regex)
    if filename and lineno and message then
      table.insert(matches, { filename = filename, lineno = tonumber(lineno), message = message, type = type })
    end
  end
  return matches
end

local ns = vim.api.nvim_create_namespace("custom_diagnostics")

local function set_diagnostics(matches)
  local diagnostics_by_file = {}

  -- Group matches by filename
  for _, match in ipairs(matches) do
    if not diagnostics_by_file[match.filename] then
      diagnostics_by_file[match.filename] = {}
    end

    local buf = vim.fn.bufadd(match.filename);
    if bufnr ~= -1 then
      local serenity = nil

      if match.type == "error" then
        serenity = vim.diagnostic.severity.ERROR;
      elseif match.type == "warning" then
        serenity = vim.diagnostic.severity.WARN;
      end

      if serenity ~= nil then
        table.insert(diagnostics_by_file[match.filename], {
          bufnr = bufnr,
          lnum = match.lineno - 1, -- Line numbers are 0-indexed in the diagnostics API
          col = 0,
          end_lnum = match.lineno - 1,
          end_col = -1,
          severity = serenity,
          message = match.message,
          source = "custom"
        })
      end
    end
  end

  -- Set diagnostics for each buffer
  local namespace = vim.api.nvim_create_namespace("custom_diagnostics")
  for filename, diagnostics in pairs(diagnostics_by_file) do
    local bufnr = vim.fn.bufadd(filename)
    if bufnr ~= -1 then
      vim.diagnostic.set(namespace, bufnr, diagnostics, {})

      if not vim.api.nvim_buf_is_loaded(bufnr) then
        set_bufenter_callback(bufnr, "diagnostics_show", function()
          vim.diagnostic.show(ns, bufnr)
        end)
      end
    end
  end
end

local terminal_buf_id = nil

local function run_command(cmd, args, callback)
  local output = ""

  local function on_output(_, data, event, exit_code)
    if event == "stdout" or event == "stderr" then
      for _, line in ipairs(data) do
        output = output .. line .. "\n"
      end
    elseif event == "exit" then
      callback(cleanup_term_string(output), exit_code == 0)
    end
  end

  -- Close the previous terminal buffer so there is only one active task at a time
  if terminal_buf_id and vim.api.nvim_buf_is_valid(terminal_buf_id) then
    local win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(win, terminal_buf_id)

    local job_id = vim.b[terminal_buf_id].terminal_job_id
    if job_id then
      vim.fn.jobstop(job_id)
    end

    vim.cmd('bdelete! ' .. terminal_buf_id)
  end

  vim.cmd('enew')
  terminal_buf_id = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_set_name(terminal_buf_id, "TaskTerminal")

  local opts = {
    stdout_buffered = true,
    stderr_buffered = true,
    on_stdout = on_output,
    on_stderr = on_output,
    on_exit = function(_, exit_code)
      on_output(nil, {}, "exit", exit_code)
    end,
  }

  vim.fn.termopen({ cmd, unpack(args) }, opts)
end

local function run_task(cmd, regex, callback)
  vim.diagnostic.reset()

  run_command(cmd, {}, function(output, success)
    local matches = find_matches(output, regex)
    set_diagnostics(matches)

    if success and callback then
      callback()
    end
  end)
end

local M = {
  run_task = run_task,
}

return M
