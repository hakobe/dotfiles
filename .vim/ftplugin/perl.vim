setlocal iskeyword+=:
setlocal isfname-=-

nnoremap <unique> <Leader>lt :<C-u>! prove -v %<CR>
nnoremap <expr> <Leader>ls ':!' . $HOME . '/.vim/libexec/vprove ' . expand('<cword>') . ' %<CR>'
