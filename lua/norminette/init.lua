local function norminette(file)
  if file == '' then
    file = vim.fn.expand('%')
    if file == '' then
      return
    end
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
    local lnum = tonumber(line:match('line:%s*(%d+)'))
    local col = tonumber(line:match('col:%s*(%d+)'))
    table.insert(items, {
      filename = file,
      lnum = lnum,
      col = col,
      text = line,
    });
  end

  vim.fn.setqflist(items, ' ')
  vim.cmd('copen')
end

return {
	norminette = norminette,
}
