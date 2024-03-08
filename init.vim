set number
set autoindent
set tabstop=4
set shiftwidth=4
set smarttab
set softtabstop=4
set mouse=a
" Cursor
set guicursor=n-v-c:block-Cursor
set guicursor+=a:ver100-iCursor
set guicursor+=n-v-c:blinkon0
set guicursor+=n:blinkwait10

" scss to css compiler on save
" autocmd BufWritePost *.scss if !isdirectory('%:p:h/css') | execute 'mkdir %:p:h/css' | endif
autocmd BufWritePost *.scss if !filereadable('%:p') | execute '!sass %:p %:p:h/css/%:t:r.css' | endif

call plug#begin()

" --- Plugins ---

" Wakatime
Plug 'wakatime/vim-wakatime'

" Colorscheme
Plug 'olimorris/onedarkpro.nvim'

" vim design
Plug 'https://github.com/preservim/nerdtree' " NerdTree
Plug 'https://github.com/vim-airline/vim-airline' " Status bar
Plug 'https://github.com/rafi/awesome-vim-colorschemes' " Retro Scheme

" Syntax Highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Markdown
Plug 'iamcco/markdown-preview.nvim'

" SFTP 
Plug 'dcampos/nvim-sftp-sync', { 'do': ':UpdateRemotePlugins' }

Plug 'https://github.com/tpope/vim-commentary' " For Commenting gcc & gc
Plug 'https://github.com/ap/vim-css-color' " CSS Color Preview
Plug 'https://github.com/lifepillar/pgsql.vim' " PSQL Pluging needs :SQLSetType pgsql.vim
Plug 'https://github.com/neoclide/coc.nvim'  " Auto Completion
Plug 'https://github.com/ryanoasis/vim-devicons' " Developer Icons
Plug 'https://github.com/tc50cal/vim-terminal' " Vim Terminal
Plug 'https://github.com/preservim/tagbar' " Tagbar for code navigation
Plug 'https://github.com/terryma/vim-multiple-cursors' " CTRL + N for multiple cursors
Plug 'https://github.com/rstacruz/vim-closer' " For brackets autocompletion
Plug 'lukas-reineke/indent-blankline.nvim' " For Indentation Guides

" Auto-completion  For Javascript
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'} " this is for auto complete, prettier and tslinting

let g:coc_global_extensions = ['coc-tslint-plugin', 'coc-tsserver', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier']  " list of CoC extensions needed

Plug 'jiangmiao/auto-pairs' "this will auto close ( [ {

" these two plugins will add highlighting and indenting to JSX and TSX files.
Plug 'yuezk/vim-js'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'maxmellon/vim-jsx-pretty'

set encoding=UTF-8

call plug#end()

" --- Settings ---

nnoremap <C-f> :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-l> :call CocActionAsync('jumpDefinition')<CR>

nmap <F8> :TagbarToggle<CR>

:set completeopt-=preview " For No Previews

let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"

" --- Just Some Notes ---
" :PlugClean :PlugInstall :UpdateRemotePlugins
"
" :CocInstall coc-python
" :CocInstall coc-clangd
" :CocInstall coc-snippets
" :CocCommand snippets.edit... FOR EACH FILE TYPE

" air-line
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''


" Colorscheme
autocmd ColorScheme * highlight Comment ctermfg=blue guifg=#169ccd " Kommentar farbe"
:colorscheme onedark
hi Normal guibg=NONE ctermbg=NONE
" Für den Hintergrund von Zeilennummern
hi LineNr guibg=NONE ctermbg=NONE
" Für den Hintergrund der Zeilen am Fensterrand
hi VertSplit guibg=NONE ctermbg=NONE
" Für den Hintergrund von Zeilen mit Warnungen/Fehlern
hi SignColumn guibg=NONE ctermbg=NONE
" Für den matchbraket highlight
hi MatchParen guibg=#4d4848 ctermbg=red


" For Syntax Highlighting
lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"cpp", "c","html", "java", "json"}, -- eine Liste der gewünschten Sprachen
  highlight = {
    enable = true,              -- false will disable the whole extension
    additional_vim_regex_highlighting = false,
  },
}
EOF
" Für scss fabren highlight
autocmd FileType .scss TSBufDisable highlight
" autocmd FileType scss :TSBufEnable highlight


"Für Indent Blankline
autocmd VimEnter * IBLEnable
let g:indent_blankline_char = '|'
let g:indent_blankline_use_treesitter = v:true
let g:indent_blankline_show_first_indent_level = v:false


" Git Gutter
let g:gitgutter_git_executable = 'B:\Users\toby\Git\cmd\git.exe'

" Markdown
let g:mkdp_auto_start = 1 
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 1 
let g:mkdp_command_for_global = 0 
let g:mkdp_open_to_the_world = 0 " 1 for open to the world
let g:mkdp_open_ip = '127.0.0.1' " IP for the server
let g:mkdp_port = '8080' " Port for the server

function! g:Open_browser(url) " Open Browser for Markdown Preview"
    silent exe '!lemonade open 'a:url
endfunction

let g:mkdp_preview_options = {
	\ 'mkit': {},
	\ 'katex': {},
	\ 'uml': {},
	\ 'maid': {},
	\ 'disable_sync_scroll': 0,
	\ 'sync_scroll_type': 'middle',
	\ 'hide_yaml_meta': 0,
	\ 'sequence_diagrams': {},
	\ 'flowchart_diagrams': {},
	\ 'content_editable': v:true,
	\ 'disable_filename': 0,
	\ }
let g:mkdp_markdown_css = ''
let g:mkdp_highlight_css = ''
let g:mkdp_browser = 'chrome'
let g:mkdp_filetypes = ['markdown', 'mkd', 'md']
let g:mkdp_theme = 'dark'
let g:mkdp_combine_preview = 0


" Ctrl-Z für Undo
nnoremap <C-z> u

" Ctrl-Y für Redo
nnoremap <C-y> <C-r>


inoremap <expr> <Tab> pumvisible() ? coc#_select_confirm() : "<Tab>"
