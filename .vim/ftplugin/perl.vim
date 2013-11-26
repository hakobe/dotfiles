setlocal iskeyword+=:
setlocal isfname-=-

if filereadable( getcwd() . '/cpanfile' )
    nnoremap <buffer> <Leader>lt :<C-u>! carton exec -- prove --nocolor -v %<CR>
    nnoremap <buffer> <expr> <Leader>lu ':! carton exec -- ' . $HOME . '/.vim/libexec/vprove ' . expand('<cword>') . ' --nocolor %<CR>'
    nnoremap <buffer> <silent> <expr> <Leader>lc ':let @* = "TEST_METHOD=' . expand('<cword>') . ' carton exec -- prove -lvr ' . expand('%') . '"<CR>'
else
    nnoremap <buffer> <Leader>lt :<C-u>! prove --nocolor -v %<CR>
    nnoremap <buffer> <expr> <Leader>lu ':!' . $HOME . '/.vim/libexec/vprove ' . expand('<cword>') . ' --nocolor %<CR>'
    nnoremap <buffer> <silent> <expr> <Leader>lc ':let @* = "TEST_METHOD=' . expand('<cword>') . ' prove -lvr ' . expand('%') . '"<CR>'
endif

inoremap <buffer> <silent> <expr> <C-]> gabbrev#i_start()
