setlocal iskeyword+=:
setlocal isfname-=-

nnoremap <buffer> <unique> <Leader>lt :<C-u>! prove -v %<CR>
nnoremap <buffer> <expr> <Leader>ls ':!' . $HOME . '/.vim/libexec/vprove ' . expand('<cword>') . ' %<CR>'
inoremap <buffer> <silent> <expr> <C-]> gabbrev#i_start()
