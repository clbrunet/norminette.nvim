nnoremap <leader>rr :lua for k in pairs(package.loaded) do if k:match('^norminette') then package.loaded[k] = nil end end<CR>
command! -nargs=? Norminette lua require('norminette').norminette('<args>')

augroup	norminette
  autocmd!
augroup END
