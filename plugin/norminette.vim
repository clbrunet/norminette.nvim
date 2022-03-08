command! NorminetteCurrentFile lua require('norminette').send_current_file_to_qflist()

command! -nargs=? -complete=file Norminette lua require('norminette').send_to_qflist('<args>')
