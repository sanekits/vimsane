" vimrc-pet.vim

imap jk <ESC>
set cmdheight=2

" Capture the path of our own script for later refresh.
let g:pet_script_path = expand('<sfile>:p')
set makeprg=plink\ *.mk


" function! PetMakeSetup()
"     " Find the first makefile in cur dir and assign it to g:mkfile
"     let g:mkfile=globpath('./','*.mk')
" 
"     if g:mkfile != ''
"         execute 'set makeprg=plink\ ' . g:mkfile
"     else
"         execute 'set makeprg=plink\ *.mk'
"     echom "Your makeprg is "  . makeprg
" endfunction

call PetMakeSetup()

command! PetRefresh execute 'source ' . g:pet_script_path
echo "Pet stuff loaded from " . g:pet_script_path

