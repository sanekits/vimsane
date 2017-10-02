" vimsane.vim
set nocompatible  " Keep this as second line always
"
" vimsane is a pre-packaged Vim installation available to 
" those who want to learn the Vim editor.  Vim can be 
" intimdating and frustrating to new users, and the learning
" curve is long.  
"
" Vimsane exists to help you become reasonably competent 
" quickly, by bundling some popular vim plugins and 
" configuration choices to make Vim a bit more 'sane' for
" learning.
"
" While you can use vimsane as your daily editor for the 
" long term, you're encouraged to learn how to customize
" and extend Vim, and you'll probably want to leave 
" vimsane behind as you do that.  This is training wheels,
" not a racing bike.
"
" If you're brand new, you should print these instructions
" and keep them handy while working.
"

" .......................................
" Level 1:  Things you should learn early 
" .......................................
"
" (Note: this includes a few things that only work in
"  vimsane, noted with a *VS* marker)
"

" This section just provides a list of commands that are 
" handy to have in your muscle memory:
"
"   i --> Enter insert mode (so you can modify text)
"
"   <ESC> --> Return to normal mode ( OR...)
"   jk   -->  Return to normal mode *VS*
"
"   :w  --> Write current file to disk
"   :e [filename]  --> Edit/open given file
"
"   :q  --> Exit vim 
"   :qa! --> Exit without saving anything
"   
"   h,l,j,k --> Basic cursor movements for left, right, down, and up
"   respectively
"
"   Ctrl-z  --> Undo change
"   Ctrl-r  --> Redo change
"
"   V -->   Select a block of text: V (and then move up or down to extend the   selection.)
"
"   y -->   copY selected block of text (i.e. "yank")
"   d -->   Delete selected block of text (i.e. "cut")
"   p -->   Paste text
"
"   :ls  --> Show a list of the files loaded
"
"   :b [name-fragment]  --> switch to loaded file 
"   :b [buffer-number]  --> switch to numbered buffer
"
"   :args [wildcards] --> Load all files matching wildcard
"
"   ,.  --> Open directory browser at current dir *VS*
"   ,m  --> Open MRU list for recently-edited files *VS*
"   ,n  --> Open browser of current buffers *VS*
"   
"
" .......................................
" Level 2:  A bit more advanced:
" .......................................
"
" Zoom a window in/out:
"   Ctrl+@ o     " Thanks to ZoomWin plugin
"
" Normalize split sizes, handy when resizing a terminal:
"
"   ctrl+w = 
"
" Redraw the screen (if ^L isn't working)
" :redraw!
"
" Capture the result of a command to register:
"   : let @u=system("ls /")    
"    { put the results of the ls into the u register }
"
"
" Repeat last command:
"   @: { first repeat }
"   @@ { subsequently } 
"
" Open quickfix window:
"   :cw
"   :copen
"   :cold  << Go to previous quickfix contents
"   :cnew  >> Go to newer quickfix contents
"
" List all matching tags:
"   :tselect {name}
"
" 	  :resize 5  (make it 5 lines high)
" 	  :resize +5 (increase by 5 lines)



"  Of course, <ESC> is famous in vim as the key that one uses to switch
"  from insert mode (editing) to 'normal' mode (moving around and issuing
"  commands. 
"
"  But ESC is not in the HOME row of most modern keyboards, and because it's
"  so frequently used, that's suboptimal.  So many users map the sequence 'jk'
"  as a second ESC key.  Your right hand can type that very rapidly, if you're
"  right-handed, and that combination of keys is rarely used in ordinary text,
"  so it's a near-perfect replacement for reaching up with your left hand to
"  hit ESC all the time.
"
"  Vim is all about "don't move from the home row on the keyboard", optimizing
"  for keystrokes and finger movements.  The most common operations are the
"  most important things to optimize.
"
"  If you actually have to type the sequence 'jk' into a document, you can
"  just pause a couple of seconds after the 'j' and then you can insert the
"  'k'.
imap jk <ESC>

" The command window sometimes spits out messages that you want to read, so
" having 2 lines for that is useful:
set cmdheight=2

" Window switching is easier if you just take over the Ctrl+Dir sequence.
" If you have 2 windows side-by-side, Ctrl-h and Ctrl-l will bounce back
" and forth between them.  Note the commonality between j,k,l, and h as
" cursor-movement commands and the Ctrl-j,Ctrl-k,Ctrl-l, and Ctrl-h for
" switching windows.  The directions correspond vertically and horizontally.
noremap <C-h> <C-w>h  
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l


" Loop through our taskrc's if they exist. These
" are small scripts which establish commands or
" options that are local to a particular directory
" or user.
function! LoadTaskRcs(baseDir)
    let l:rcdir= expand(a:baseDir)
    let l:myRcs=split( globpath( l:rcdir,'*.vim'),'\n')
    if len(l:myRcs) == 0
        return 0
    endif
    for rcs in myRcs
        execute "source " . rcs
    endfor
    return 0
endfunction

" Capture the path of our own script for later refresh.
let g:vimsane_script_path = expand('<sfile>:p')

command! VsRefresh execute 'source ' . g:vimsane_script_path

" We first search the user's ~/.taskrc directory for *.vim,
" and then we search ./.taskrc.
call LoadTaskRcs("~/.taskrc")
call LoadTaskRcs(".taskrc")
"

echo "Vimsane loaded from " . g:vimsane_script_path

let g:vimsane_loaded=1

