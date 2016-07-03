" vim:set ts=2 sts=2 sw=2 expandtab:

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" I PREFER vim-plug FOR PLUGIN MANAGEMENT
" (https://github.com/junegunn/vim-plug)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
filetype off              " required!

call plug#begin('~/.vim/plugged')

" original repos on github
Plug 'Raimondi/delimitMate'
Plug 'ervandew/supertab'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-rails'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tsaleh/vim-align'
Plug 'vim-scripts/bufexplorer.zip'
Plug 'vim-scripts/closetag.vim'
Plug 'godlygeek/csapprox'
Plug 'majutsushi/tagbar'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/syntastic'
Plug 'scrooloose/nerdtree'
Plug 'mrtazz/molokai.vim'
Plug 'morhetz/gruvbox'
Plug 'sickill/vim-monokai'
Plug 'kchmck/vim-coffee-script'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'
" Plug 'garbas/vim-snipmate'
Plug 'fatih/vim-go'
Plug 'takac/vim-commandcaps'            " some commands should also work if you type caps, like :WQ
Plug 'cespare/vim-toml'                 " toml markup syntax support
Plug 'pangloss/vim-javascript'          " better js syntax support
Plug 'rking/ag.vim'                     " wrapper around silver searcher for finding strings in files
Plug 'bling/vim-airline'                " pretty vim status line
Plug 'vim-airline/vim-airline-themes'   " airline themes
Plug 'tpope/vim-fugitive'               " git in vim
Plug 'ctrlpvim/ctrlp.vim'               " quick open file/tag
Plug 'Glench/Vim-Jinja2-Syntax'         " jinja2 templates
Plug 'mxw/vim-jsx'                      " JSX syntax support
Plug 'vim-scripts/diffchar.vim'         " better diff'ing using vimdiff
Plug 'mbbill/undotree'
Plug 'klen/python-mode'                 " python support
Plug 'sophacles/vim-bundle-mako'        " mako template engine
Plug 'vim-scripts/tComment'             " comments
Plug 'szw/vim-tags'                     " code tag support
Plug 'elzr/vim-json'                    " Better JSON syntax highlight support for Vim
Plug 'tpope/vim-jdaddy'                 " JSON manipulation and pretty printing
Plug 'altercation/vim-colors-solarized' " Solarized color theme

" Elixir?... Why not.
Plug 'elixir-lang/vim-elixir'

" Experimental Clojure Stuff
Plug 'tpope/vim-fireplace'
Plug 'guns/vim-clojure-static'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'kovisoft/paredit'
" Plug 'venantius/vim-eastwood'

au VimEnter * RainbowParentheses
let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}'], ['<', '>']]

" List of colors that you do not want. ANSI code or #RRGGBB
let g:rainbow#blacklist = [233, 234]

" au Syntax * RainbowParenthesesLoadRound
" au Syntax * RainbowParenthesesLoadSquare
" au Syntax * RainbowParenthesesLoadBraces

"**** Plugs that were once interesting, but
"**** not anymore (maybe someday)

" let Vundle manage Vundle
"Plug 'gmarik/vundle'
"Plug 'edsono/vim-matchit'
"Plug 'RobbieClarken/vim-haproxy'
"Plug 'Valloric/YouCompleteMe'
"Plug 'editorconfig/editorconfig-vim'
"Plug 'powerline/powerline'
"Plug 'wting/rust.vim' " Rust
"Plug 'tpope/vim-speeddating'
"Plug 'tpope/vim-unimpaired'
"Plug 'c9s/colorselector.vim'
"Plug 'godlygeek/tabular'
"Plug 'tpope/vim-haml'
"Plug 'tpope/vim-pathogen'
"Plug 'nono/vim-handlebars'
"Plug 'Lokaltog/powerline'
"Plug 'terryma/vim-multiple-cursors'
"
"Plug 'AndrewRadev/vim-eco'
"Plug 'vim-scripts/Better-CSS-Syntax-for-Vim'
"Plug 'ap/vim-css-color'
"Plug 'troydm/easybuffer.vim'
"Plug 'nono/vim-handlebars'
"Plug 'juvenn/mustache.vim'
"Plug 'motus/pig.vim'
"Plug 'robgleeson/hammer.vim'
"Plug 'sirver/ultisnips'
"Plug 'derekwyatt/vim-scala'
"Plug 'gre/play2vim'
"Plug 'bdd/vim-scala'
"Plug 'ervandew/screen'
"Plug 'VimClojure'
"Plug 'nathanaelkane/vim-indent-guides'
"Plug 'elubow/cql-vim'
"Plug 'ChrisKempson/Vim-Tomorrow-Theme'
"Plug 'puppetlabs/puppet-syntax-vim'

call plug#end()
filetype plugin indent on " required!

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASIC EDITING CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" allow unsaved background buffers and remember marks/undo for them
set hidden
set visualbell t_vb= " avoid visual bell on errors

" remember more commands and search history
set history=10000
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set laststatus=2
set showmatch
set incsearch
set hlsearch
" make searches case-sensitive only if they contain upper-case characters
set ignorecase smartcase
" highlight current line
set cursorline
set cmdheight=1
set switchbuf=useopen
set numberwidth=5
set number " show line number
"set showtabline=2
set winwidth=79
" This makes RVM work inside Vim. I have no idea why.
set shell=bash
" Prevent Vim from clobbering the scrollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
set t_ti= t_te=
" keep more context when scrolling off the end of a buffer
set scrolloff=3
" Store temporary files in a central spot
"set backup
"set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
"set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
" display incomplete commands
set showcmd
" Enable highlighting for syntax
syntax on
" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on
" use emacs-style tab completion when selecting files, etc
set wildmode=full "longest,list
set wildchar=<Tab>
" make tab completion for files/buffers act like bash
set wildmenu

" map , (find previous match on t/T/f/F) to /
nnoremap \ ,

" map leader to commaa
let mapleader=","

set exrc   " enable per-directory .vimrc files
set secure " disable unsafe commands in local .vimrc files"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CUSTOM AUTOCMDS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup vimrcEx
  " Clear all autocmds in the group
  autocmd!
  autocmd FileType text setlocal textwidth=78
  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  "for some files, autoindent with two spaces, always expand tabs
  autocmd FileType ruby,haml,eruby,yaml,html,javascript,sass,cucumber,sass,scss,less set ai sw=2 sts=2 et
  autocmd FileType python set sw=4 sts=4 et

  " associate tpl file extension with jinja html syntax highlight
  au BufNewfile,BufRead *.tpl,*.html,*.j2 set filetype=jinja
  au BufNewfile,BufRead *.less set filetype=sass

  autocmd! BufRead,BufNewFile *.sass,*.scss setfiletype sass 

  " associate puppet files with ruby syntax
  autocmd! BufRead,BufNewFile *.pp setfiletype ruby

  autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:&gt;
  autocmd BufRead *.markdown  set ai formatoptions=tcroqn2 comments=n:&gt;

  "conf files should use dosini syntax highlight
  autocmd BufRead,BufNewFile *.conf setf dosini

  " upstart file syntax highlight
  autocmd BufRead,BufNewFile *.upstart setf upstart

  " puppet syntax highlight is just ruby
  autocmd BufRead,BufNewFile *.pp setf ruby

  " Indent p tags
  "autocmd FileType html,eruby if g:html_indent_tags !~ '\\|p\>' | let g:html_indent_tags .= '\|p\|li\|dt\|dd' | endif

  " Don't syntax highlight markdown because it's often wrong
  autocmd! FileType mkd setlocal syn=off

  " Leave the return key alone when in command line windows, since it's used
  " to run commands there.
  autocmd! CmdwinEnter * :unmap <cr>
  autocmd! CmdwinLeave * :call MapCR()
augroup END

" Save undo history
if has('persistent_undo')
    set undolevels=5000
    set undodir=$HOME/.vim-undo-files
    set undofile
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLOR
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set t_Co=256 " 256 colors
syntax enable

let g:solarized_termcolors=256
"set background=light
set background=dark
"colorscheme molokai
colorscheme solarized
"colorscheme Tomorrow-Night
"colorscheme grb256
"colorscheme ir_black


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" STATUS LINE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
:set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC KEY MAPS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>y "*y
" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
" Insert a hash rocket with <c-l>
imap <c-l> <space>=><space>
" Can't be bothered to understand ESC vs <c-c> in insert mode
imap <c-c> <esc>
" Clear the search buffer when hitting return
function! MapCR()
  nnoremap <cr> :nohlsearch<cr>
endfunction
call MapCR()
nnoremap <leader><leader> <c-^>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SOME OF MY PREFERED KEY BINDINGS (shilo)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" activate CloseTag plugin only on relevant files
autocmd FileType html,htmldjango,jinjahtml,eruby,mako let b:closetag_html_style=1
autocmd FileType html,xhtml,xml,htmldjango,jinjahtml,eruby,mako source ~/.vim/plugged/closetag.vim/plugin/closetag.vim

" key mapping to move line/selected lines using Ctrl-up/down 
nnoremap <C-Down> :m+<CR>==
nnoremap <C-Up> :m-2<CR>==
inoremap <C-Down> <Esc>:m+<CR>==gi
inoremap <C-Up> <Esc>:m-2<CR>==gi
vnoremap <C-Down> :m'>+<CR>gv=gv
vnoremap <C-Up> :m-2<CR>gv=gv

" same thing with j/k keys
nnoremap <C-j> :m+<CR>==
nnoremap <C-k> :m-2<CR>==
inoremap <C-j> <Esc>:m+<CR>==gi
inoremap <C-k> <Esc>:m-2<CR>==gi
vnoremap <C-j> :m'>+<CR>gv=gv
vnoremap <C-k> :m-2<CR>gv=gv

" indent in/out selection or current line with Alt-[/ Alt-]
nnoremap <A-[> <<
nnoremap <A-]> >>
vnoremap <A-[> <gv
vnoremap <A-]> >gv
inoremap <A-[> <Esc><<
inoremap <A-]> <Esc>>>

" duplicate current row
nnoremap <C-d> Vyp
inoremap <C-d> <Esc>Vyp<Esc>i
vnoremap <C-d> y<Esc>o<Esc>p

" Tidy html and xml
command! TidyHtml :%!tidy -q -i -html --show-errors 0 2>/dev/null
command! TidyXml  :%!tidy -q -i -xml  --show-errors 0 2>/dev/null
command! PrettyJson  :%!python -mjson.tool 0 2>/dev/null

" add support for dictionary completion
set dictionary+=/usr/share/dict/words
set dictionary+=/usr/share/dict/web2

" make sure vim's completion doesn't inspect require/include file
set complete-=i

if has('gui_running')
  " remove useless menu
  set guioptions-=T
  set guioptions-=R
  set guioptions-=r
  set guioptions-=l
  set guioptions-=L

  " font
  set guifont=Inconsolata:h16
endif

"map <leader>z :EasyBufferToggle<cr>
map <leader>z :BufExplorerVerticalSplit<cr>
" map <leader>z :Buffers<cr>
map <leader>m :TagbarToggle<cr>

" Ctrl-P mapping
map <leader>l :CtrlPTag<CR>
let g:ctrlp_map="<leader>p"
let g:ctrlp_use_caching = 0  "always load fresh content
let g:ctrlp_match_window = 'bottom,order:ttb,min:1,max:20,results:20'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_show_hidden = 1
let g:ctrlp_working_path_mode = 0
let g:ctrlp_extensions = ['dir']

" vim-javascript
let g:javascript_enable_domhtmlcss = 1

if executable("ag")
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s --hidden -l --nocolor -g ""'
endif

" run Ag on the current search
map <leader>a *:AgFromSearch<cr>

" toggle NERDTree in the current project
map <leader>b :NERDTreeToggle<cr>

" make sure NERDTree uses wildignore
let NERDTreeRespectWildIgnore = 1

" EasyBuffer bufname format
"let g:easybuffer_bufname = "expand('#'.bnr.':t')"

" some ignore patterns for CommandT and CtrlP
set wildignore+=*.class,**/*.pyc,**/*.jpg,**/*.jpeg,**/*.png,**/*.gif,**/*.tiff,**/*.pdf
set wildignore+=**/*~,**/*.swp,**/*.swo,**/*.o,**/*.so,**/*.obj,*/.git,*/.hg,*$*.class
set wildignore+=**/*.gz,**/*.bz2,**/*.tgz,**/*.tbz,tmp/cache/**,tmp/assets/cache/**
set wildignore+=**/*eot,**/*.woff,**/*.ttf,spec/cassettes/**,history/**,public/images/**

" open Git status window with 20 rows
nmap <leader>gs :Gstatus<CR><C-w>10+

" Stage the current file
nmap <leader>ga :Git add %<CR><CR>\|:echo 'staged file ' . expand('%')<CR>

" When writing a file, if there are errors, have Syntastic plugin mark them
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=0

"let g:syntastic_python_flake8_post_args='--ignore=E501,E128,E225'
" let g:syntastic_python_checkers = ['flake8']
" let g:syntastic_python_checkers = ['pylint']
" let g:syntastic_python_flake8_args='--rcfile=$HOME/.pylintrc'
" let g:syntastic_python_flake8_args='--ignore=C901,E129,E501,E223,E224,E225,E203,E202,E302,E402,E261,E262,E265,E701,E201,E291,E241,E126,E127,E128,F403,W801'
" let g:syntastic_python_pep8_args='--ignore=C901,E129,E501,E223,E224,E225,E203,E202,E302,E402,E261,E262,E265,E701,E201,E291,E241,E126,E127,E128,F403,W801'

" disable syntastic for python (using python-mode)
let g:syntastic_mode_map = { 'passive_filetypes': ['python'] }
let g:syntastic_go_checkers = ['go', 'gofmt', 'govet']
let g:syntastic_cpp_compiler_options = ' -std=c++1y'
let g:syntastic_cpp_checkers = ['gcc']
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_scss_checkers = ['scss_lint']
let g:syntastic_sass_checkers = ['scss_lint']

" Don't play fancy syntax games in JSON buffer syntax highlight
let g:vim_json_syntax_conceal = 0

" don't check on save for SASS/SCSS file (super slow)
"let g:syntastic_ignore_files = ['\m\c\.scss$', '\m\c\.sass$']
"let g:syntastic_mode_map = { 'passive_filetypes': ['sass', 'scss'] }

" require JSX in .js files
let g:jsx_ext_required = 0

" configure pymode linting
let g:pymode_lint = 1
let g:pymode_lint_unmodified = 1
let g:pymode_lint_checkers = ['pylint']
let g:pymode_lint_sort = ['E', 'C', 'I']
let g:pymode_lint_cwindow = 0

" disable auto-folding in mode-python extension
let g:pymode_folding = 0
let g:pymode_rope_regenerate_on_write = 0
let g:pymode_doc = 0
let g:pymode_doc_bind = 'K'
let g:pymode_rope_completion = 0

" Custom commenting formats
let g:NERDCustomDelimiters = {
      \ 'ruby':       { 'left': '# ' },
      \ 'python':     { 'left': '# ' },
      \ 'javascript': { 'left': '// ' },
      \ 'jinja':      { 'left': '{# ', 'right': ' #}' },
      \ }

" make sure UltiSnips uses Python 2
let g:UltiSnipsUsePythonVersion = 2

" disable visual mode (because I HATE IT)
map Q <c-V>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ARROW KEYS ARE UNACCEPTABLE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" hitting jk while in insert mode will change back to normal
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
inoremap jk <Esc>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Also move in single line even when line is wrapped
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap j gj
nnoremap k gk

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OPEN FILES IN DIRECTORY OF CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>v :view %%

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>n :call RenameFile()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PROMOTE VARIABLE TO RSPEC LET
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! PromoteToLet()
  :normal! dd
  " :exec '?^\s*it\>'
  :normal! P
  :.s/\(\w\+\) = \(.*\)$/let(:\1) { \2 }/
  :normal ==
endfunction
:command! PromoteToLet :call PromoteToLet()
":map <leader>l :PromoteToLet<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" EXTRACT VARIABLE (SKETCHY)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! ExtractVariable()
    let name = input("Variable name: ")
    if name == ''
        return
    endif
    " Enter visual mode (not sure why this is needed since we're already in
    " visual mode anyway)
    normal! gv

    " Replace selected text with the variable name
    exec "normal c" . name
    " Define the variable on the line above
    exec "normal! O" . name . " = "
    " Paste the original selected text to be the variable value
    normal! $p
endfunction
vnoremap <leader>rv :call ExtractVariable()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" INLINE VARIABLE (SKETCHY)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InlineVariable()
    " Copy the variable under the cursor into the 'a' register
    :let l:tmp_a = @a
    :normal "ayiw
    " Delete variable and equals sign
    :normal 2daW
    " Delete the expression into the 'b' register
    :let l:tmp_b = @b
    :normal "bd$
    " Delete the remnants of the line
    :normal dd
    " Go to the end of the previous line so we can start our search for the
    " usage of the variable to replace. Doing '0' instead of 'k$' doesn't
    " work; I'm not sure why.
    normal k$
    " Find the next occurence of the variable
    exec '/\<' . @a . '\>'
    " Replace that occurence with the text we yanked
    exec ':.s/\<' . @a . '\>/' . @b
    :let @a = l:tmp_a
    :let @b = l:tmp_b
endfunction
nnoremap <leader>ri :call InlineVariable()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MAPS TO JUMP TO SPECIFIC COMMAND-T TARGETS AND FILES
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>gr :topleft :split config/routes.rb<cr>
function! ShowRoutes()
  " Requires 'scratch' plugin
  :topleft 100 :split __Routes__
  " Make sure Vim doesn't write __Routes__ as a file
  :set buftype=nofile
  " Delete everything
  :normal 1GdG
  " Put routes output in buffer
  :0r! rake -s routes
  " Size window to number of lines (1 plus rake output length)
  :exec ":normal " . line("$") . "_ "
  " Move cursor to bottom
  :normal 1GG
  " Delete empty trailing line
  :normal dd
endfunction
map <leader>gR :call ShowRoutes()<cr>
""map <leader>gv :CommandT app/views<cr>
""map <leader>gc :CommandT app/controllers<cr>
""map <leader>go :CommandT app/models/observers<cr>
""map <leader>gm :CommandT app/models<cr>
""map <leader>gh :CommandT app/helpers<cr>
""map <leader>ga :CommandT app/assets<cr>
""map <leader>gS :CommandT app/serializers<cr>
""map <leader>gw :CommandT app/workers<cr>
""map <leader>gd :CommandT db<cr>
""map <leader>gs :CommandT spec<cr>
""map <leader>gt :CommandTTag<cr>
""map <leader>gf :CommandT features<cr>
""map <leader>gl :CommandT lib<cr>
""map <leader>gp :CommandT public<cr>
""map <leader>gg :topleft 100 :split Gemfile<cr>
""map <leader>f :CommandT<cr>
""map <leader>F :CommandT %%<cr>
"** map <leader>c :!ctags -R --languages=ruby,python,javascript,sh,sql --exclude=.git --exclude=node_modules --exclude=bower_components --exclude=.tmp --exclude=tmp<cr>
map <leader>c :TagsGenerate .<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SWITCH BETWEEN TEST AND PRODUCTION CODE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! OpenTestAlternate()
  let new_file = AlternateForCurrentFile()
  exec ':e ' . new_file
endfunction
function! AlternateForCurrentFile()
  let current_file  = expand("%")
  let new_file      = current_file
  let in_spec       = match(current_file, '^spec/') != -1
  let going_to_spec = !in_spec
  let in_app        = match(current_file, '\<controllers\>') != -1 || match(current_file, '\<models\>') != -1 || match(current_file, '\<views\>') != -1 || match(current_file, '\<helpers\>') != -1 || match(current_file, '\<workers\>') != -1
  if going_to_spec
    if in_app
      let new_file = substitute(new_file, '^app/', '', '')
    end
    let new_file = substitute(new_file, '\.rb$', '_spec.rb', '')
    let new_file = 'spec/' . new_file
  else
    let new_file = substitute(new_file, '_spec\.rb$', '.rb', '')
    let new_file = substitute(new_file, '^spec/', '', '')
    if in_app
      let new_file = 'app/' . new_file
    end
  endif
  return new_file
endfunction
nnoremap <leader>. :call OpenTestAlternate()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RUNNING TESTS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"map <leader>t :w\|:!py.test tests --tb=short<cr>
map <leader>t :call RunPytestOnCurrentFile()<cr>
map <leader>T :call RunNearestPytest()<cr>
map <leader>d :call AddPDBSetTrace()<cr>
"map <leader>c :w\|:!cucumber --drb %<cr>
"map <leader>c :w\|:!script/features<cr>
"map <leader>w :w\|:!script/features --profile wip<cr>


function! RunTestFile(...)
    if a:0
        let command_suffix = a:1
    else
        let command_suffix = ""
    endif

    " Run the tests for the previously-marked file.
    let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\)$') != -1
    if in_test_file
        call SetTestFile()
    elseif !exists("t:grb_test_file")
        return
    endif
    call RunTests(t:grb_test_file . command_suffix)
endfunction

function! RunNearestTest()
    let spec_line_number = line('.')
    "call RunTestFile(":" . spec_line_number . " -b")
    call RunTestFile(":" . spec_line_number)
endfunction

function! RunPytestOnCurrentFile()
  let test_file = expand('%:')
  exec ":!py.test --verbose --random " . test_file
endfunction

"
" Search for nearest test function or class
" and run it. If none is found, just run entire file.
"
function! RunNearestPytest()
  " save the location of the current line
  let current_line_num = line('.')

  " get the name of the current test file
  let test_path = expand('%:')

  let func_name = 0

  " go to nearset test function
  if search('def test_', 'bW') != 0
    " get the current function name
    let func_name = split(substitute(getline('.'), 'def ', '', ''), '(')[0]
    let func_name = substitute(func_name, ' ', '', 'g')
  endif

  if search('class Test', 'bW') != 0
    let class_name = substitute(getline('.'), 'class ', '', '')
    " remove any trailing : or ( )
    let class_name = split(class_name, '(')[0]
    let class_name = substitute(class_name, ')', '', 'g')
    let class_name = substitute(class_name, ':', '', 'g')

    if class_name != ''
      let test_path = test_path . '::' . class_name
    endif
  endif

  " format the pytest path to run
  if func_name !~ 0
    let test_path = test_path . '::' . func_name
  endif

  " go back to the original line number
  exec ":" . current_line_num

  exec ":!py.test --verbose --random -vv " . test_path
endfunction

" Remove 'import ipdb' at top of file if exists
" add ipdb.set_trace trace above the current lin
function! AddPDBSetTrace()

  if expand('%:e') == 'py'
    let current_line_num = line('.')
    let current_line = getline('.')

    let line_offset = 1

    echo current_line_num

    " update current line number
    let current_line_num = line('.')

    " get the indent level
    let indent_level = IndentLevel(current_line_num)

    " create a properly indented pdb.set_trace statement
    let fmt_str = "%" . ( indent_level + len('import pdb; pdb.set_trace()') ) . "S"
    let set_trace_str = printf(fmt_str, 'import pdb; pdb.set_trace()')

    " add the import line above the current line
    call append((current_line_num - 1), set_trace_str)

    " Save the buffer
    exec ":w"
  endif
endfunction

function! IndentLevel(lnum)
    "return indent(a:lnum) / &shiftwidth
    return indent(a:lnum) 
endfunction

function! SetTestFile()
    " Set the spec file that tests will be run for.
    let t:grb_test_file=@%
endfunction

function! RunTests(filename)
    " Write the file and run tests for the given filename
    :w
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    if match(a:filename, '\.feature$') != -1
      exec ":!script/features " . a:filename
    else
        if filereadable("script/test")
            exec ":!script/test " . a:filename
        elseif filereadable("Gemfile")
          exec ":!zeus rspec " . a:filename
        else
          exec ":!rspec --color " . a:filename
        end
    end
endfunction
"""exec ":!bundle exec rspec --drb --color " . a:filename

function! ImportRelativePath()
  let l:dest = expand('%:p')
  let l:src = system("find . -iname 'AppsDashboard*'")
python << endpython
import os.path
dest = vim.eval("l:dest")
src = vim.eval("l:src")
path = os.path.relpath(os.path.abspath(src), os.path.abspath(dest))
vim.command('let l:relative_path = "{}"'.format(path))
endpython
  echo l:relative_path
endfunction

function! GetAbsPath(filepath)

python << endpython
import os.path
abspath = os.path.abspath(vim.eval("a:filepath"))
vim.command('let l:abspath = "{}"'.format(abspath))
endpython

  return l:abspath
endfunction

func! ListMonths()
  call complete(col('.'), ['January', 'February', 'March',
  \ 'April', 'May', 'June', 'July', 'August', 'September',
  \ 'October', 'November', 'December'])
  return ''
endfunc

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Md5 COMMAND
" Show the MD5 of the current buffer
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
command! -range Md5 :echo system('echo '.shellescape(join(getline(<line1>, <line2>), '\n')) . '| md5')

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OpenChangedFiles COMMAND
" Open a split for each dirty file in git
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! OpenChangedFiles()
  only " Close all windows, unless they're modified
  let status = system('git status -s | grep "^ \?\(M\|A\|UU\)" | sed "s/^.\{3\}//"')
  let filenames = split(status, "\n")
  exec "edit " . filenames[0]
  for filename in filenames[1:]
    exec "sp " . filename
  endfor
endfunction
command! OpenChangedFiles :call OpenChangedFiles()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" InsertTime COMMAND
" Insert the current time
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
command! InsertTime :normal a<c-r>=strftime('%F %H:%M:%S.0 %z')<cr>

" QuickFix command
command! -nargs=0 -bar Qargs execute 'args' QuickfixFilenames()
function! QuickfixFilenames()
  " Building a hash ensures we get each buffer only once
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction

" Prettify JSON in current buffer/range
command! -range -nargs=0 -bar JsonTool <line1>,<line2>!python -m json.tool
