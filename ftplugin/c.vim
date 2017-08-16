" CPP files use c.vim
set shiftwidth=2
set tabstop=2

nmap <leader>d :w<CR><leader>r:VBGkill<CR>:call vebugger#gdb#start('main', {'args': []})<CR>
imap <leader>d <ESC>:w<CR><leader>r:VBGkill<CR>:call vebugger#gdb#start('main', {'args': []})<CR>i

function! Include(fname)
  execute "normal! mzggO#include <" . a:fname . ">\<ESC>{v}h:sort u\<CR>'z"
endfunction

command! -nargs=* Include call Include( '<args>' )

imap <leader>i  <C-o>:Include 
nmap <leader>i  :Include 
