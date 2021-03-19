local function nn()
	local output = vim.call("execute", "!norminette ~/Data/Documents/Dev/test/test.c")
	print(output)
end

return {
	nn = nn
}
