function! SyntaxCheckers_perl_efmperl_GetLocList() dict
    let makeprg = self.makeprgBuild({
        \ 'exe': expand('~/.vim/tools/efm_perl.pl') })
 
    let errorformat = '%f:%l:%m'
 
    return SyntasticMake({
        \ 'makeprg': makeprg,
        \ 'errorformat': errorformat,
        \ 'defaults': {'type': 'E'} })
endfunction
 
call g:SyntasticRegistry.CreateAndRegisterChecker({
    \ 'filetype': 'perl',
    \ 'name': 'efmperl',
    \ 'exec': 'perl'})
