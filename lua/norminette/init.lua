local function get_qf_item(file, line)
  return {
    filename = file,
    lnum = tonumber(line:match('line:%s*(%d+)')),
    col = tonumber(line:match('col:%s*(%d+)')),
    vcol = true,
    text = line,
  }
end

local function send_current_file_to_qflist()
  local file = vim.fn.expand('%')
  if file == '' then
    return
  end

  local output = vim.fn.systemlist('norminette ' .. file)
  if output[1]:find('OK') ~= nil then
    print(output[1])
    return
  elseif output[1]:find('not valid C or C header file') ~= nil then
    print(output[1])
    return
  end
  table.remove(output, 1)

  local items = {}
  for _, line in ipairs(output) do
    table.insert(items, get_qf_item(file, line));
  end

  vim.fn.setqflist(items, ' ')
  vim.cmd('copen')
end

local function send_to_qflist(args)
  args = args or ''
  local output = vim.fn.systemlist('norminette ' .. args)

  local items = {}
  local file
  for _, line in ipairs(output) do
    if line:find('Error') ~= nil then
      if line:find('not valid C or C header file') ~= nil then
      elseif line:find('Error!') ~= nil then
        file = line:match('^(.*):')
      else
        table.insert(items, get_qf_item(file, line));
      end
    end
  end

  if next(items) ~= nil then
    vim.fn.setqflist(items, ' ')
    vim.cmd('copen')
  end
end

return {
	send_current_file_to_qflist = send_current_file_to_qflist,
	send_to_qflist = send_to_qflist,
}
