function!	Nn()
	" dont forget to remove this one ...
	lua for k in pairs(package.loaded) do if k:match("^nn") then package.loaded[k] = nil end end
	lua require("nn").nn(3)
endfunction

command! Nn call Nn()

augroup	Nn
	autocmd!
augroup END
