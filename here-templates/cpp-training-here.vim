" cpp-training-here.vim
"

" Individual dirs can be customized with '.taskrc/here.init.vim' 
" and .taskrc/here.final.vim, which wrap the code in .taskrc/here.vim
" so the user has the final say.
"
function! HereInit()
    " If here-init exists, run that first:
    if filereadable('.taskrc/here.init.vim')
        source .taskrc/here.init.vim
    endif
endfunction
call HereInit()

command! HereLoad args *.cpp *.h *.xsd *.cfg *.mk *.dat

command! HereClean !plink -d stage lab0.mk clean

command! HereRetag !ctags -R

command! HereDebug !tv8 *.tsk 

set makeprg=.taskrc/build.sh

function! HereFinal()
    if filereadable('.taskrc/here.final.vim')
        source .taskrc/here.final.vim
    endif
endfunction
call HereFinal()


