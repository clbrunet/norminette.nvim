nnoremap <leader>rr :lua for k in pairs(package.loaded) do if k:match('^norminette') then package.loaded[k] = nil end end<CR>

command! -nargs=? -complete=file Norminette lua require('norminette').send_to_qflist('<args>')
command! NorminetteCurrentFile lua require('norminette').send_current_file_to_qflist()

augroup	norminette
  autocmd!
augroup END
