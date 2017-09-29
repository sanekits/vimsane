" vimsane.vim

imap jk <ESC>
set cmdheight=2

" Capture the path of our own script for later refresh.
let g:vimsane_script_path = expand('<sfile>:p')

command! VsRefresh execute 'source ' . g:vimsane_script_path
echo "Vimsane loaded from " . g:vimsane_script_path

