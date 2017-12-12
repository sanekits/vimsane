" _vs_hello.vim
"
" For brand-new vimsane users, this script puts up a split window with a
" "hello world" example program on the left and the vimsane.vim commentary
" on the right.
"
" When vimsane installs itself, it creates a symlink from this file to
" ~/.vim/hello.vim.  The user is invited to remove that link when they no
" longer want this auto-start to happen.
"

let s:bufcnt=len(getbufinfo({'buflisted':1}))

" If there's only one open buffer:
if s:bufcnt==1

    " And the buffer has no name:
    if bufname('%')==''

        e ~/.vim/vimsane.vim
        vsplit ~/.vim/vs-hello-world.cpp

        echo "===== Vimsane says: ======"
        echo "I set you up so that if you launch vim with no arguments, it will open 2 files side-by-side to introduce itself.  When you get tired of this behavior, just remove ~/.vim/vs_hello.vim."
    endif
endif


