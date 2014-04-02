" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>
 
" Always show statusline
set laststatus=2

" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256

" Set syntax on
syntax on

" Line numbers
set nu

" Lazarus files are pascal!!!
autocmd BufRead,BufNewFile *.lpr set syntax=pascal

" Pathogen stuff
execute pathogen#infect()

" Setup color scheme
colorscheme zenburn

" Save/Load fold layouts
au BufWinLeave * mkview
au BufWinEnter * silent loadview

" Enable mouse input
set mouse=a

" TComment bind
map <leader>c <c-_><c-_>

" Pascal comment fix
autocmd FileType pascal set comments=://

" Read MS-WORD DOCS!!!
autocmd BufReadPre *.doc set ro
autocmd BufReadPre *.doc set hlsearch!
autocmd BufReadPost *.doc %!antiword "%"


