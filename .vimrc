" ===============
" IDEAS AND TODOS
" ===============
"
" Philosophy: The normal mode of vim should be left intact in order to learn
" 	all the features, whereas the insert and select mode can be customized
" 	to work as in normal editors. There should be predefined settings for
" 	various activities which get activates by running a command. E.g.,
" 	:WriteMath, :CorrectMath, :WriteProse, :WritePython, ... 
" 
" 1. Write a coc snippet which searches for a citation on MathSciNet or
" connect it with an existing tool to fetch citation.
" 2. Write a coc snippet (or copy from castel.dev) which includes the result
" of a computation in Mathematica.
"
" =========
" RESOURCES 
" =========
"
" [1] https://vimawesome.com/ for plugins for writers.
" [2] https://castel.dev/post/lecture-notes-1/ for tips how to take math notes.
" [3] https://vim.fandom.com/wiki/Vim_Tips_Wiki for various tips
" [4] https://github.com/neoclide/coc.nvim for Coc help
"
" ========
" SETTINGS
" ========
"
" ===============================
" MY PLUGIN MANAGER: vim-plug
" ===============================

call plug#begin('~/.vim/plugged')

"	Plug 'reedes/vim-pencil'

"	Plug 'preservim/nerdcommenter'

"	Plug 'ervandew/supertab'

"	Plug 'SirVer/ultisnips', { 'on': []} 
"		let g:UltiSnipsSnippetDirectories=["UltiSnips", "my-snippets"]
"		let g:UltiSnipsExpandTrigger = '<Tab>'
"		let g:UltiSnipsJumpForwardTrigger = '<Tab>'
"		let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'

	Plug 'lervag/vimtex'

"	Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'tex'}

"	Plug 'arcticicestudio/nord-vim'

"	Plug 'lifepillar/vim-gruvbox8'

	Plug 'lifepillar/vim-solarized8'

	Plug 'neoclide/coc.nvim', {'branch': 'release'}
" 		In order to run Coc, install NodeJS first. Install yarn if you want to build coc from
" 		source. If there is a Javascript error on startup, try the
" 		following command ':call coc#util#install()'. 
" 		Install the vimtex plugin via :CocInstall coc-vimtex
call plug#end()
"
" ===================
" GENERAL VIM OPTIONS
" ===================

source $VIMRUNTIME/defaults.vim
"       Load the standard vim defaults.

set nocompatible
" 	Noncompativility mode --- allows Vi iMprovements even when .vimrc is
" 	present in the project directory.

filetype plugin on 
" 	Enables running specific commands when filetype is detected.

autocmd FileType json syntax match Comment +\/\/.\+$+
" 	Corrects syntax highlighting of comments in coc-config.json

syntax on
"	Enables syntax highlighting.

set backspace=indent,eol,start
"	Makes backspace to delete everything in the insert mode.

set hlsearch
"	Highlights search results

set incsearch
"	Turns on incremental searchingi, i.e., searching as typing.

" set selection=exclusive
" 	Inclusive or exclusive selection. The default inclusive includes the last
" 	character in the selection. However, when pasting the cursor is set to
" 	the last character, not after the pasted text. Exclusive does it
" 	differently but collides with some vimtex features for selecting
" 	an environment or delimiters.

set keymodel=startsel
"	Press shift to enter the select mode. The philosophy is to make the
"	select mode work the same as usual editors. However, it works somehow
"	in GVIM only!

set selectmode=key,mouse
" 	The selection mode is entered after pressing shift or mouse. 

"set clipboard=unnamedplus
"	Use the system's clipboard for copy-paste.

set number
" 	Turn on line numbering.

set wildmenu
" 	Display wild menu while typing a command.

set wildmode=longest:full,full
" 	Options for wildmenu: complete the longest common string and then
" 	each full match

" filetype indent off
"    	Disable autoindentation

"set noshowmode
" 	Do not display the mode in the status line.

"set conceallevel=0
" 	Do not conceal syntax.

colorscheme solarized8 
"	Set colorscheme.

set background=light
"   	Sets background color.

"hi Conceal ctermbg=0 ctermfg=15
"	Correct the color of concealed symbols in vim. Correc!!

set breakindent
"	Enable indentation of wrapped line

"set breakindentopt=shift:2,min:40,sbr
"	Indent by additional two spaces on wrapped lines when there is more
"	than 40 symbols on one line

set showbreak=>> 
"	Denote the broken wrapped line by >>

" ====
" GVIM
" ====

set guifont=DejaVu\ Sans\ Mono\ 12
"	Sets font in gvim.
"
set guioptions-=T
" 	Remove toolbar
set guioptions-=m
" 	Remove menu bar
set guioptions-=r
" 	Removes right hand scroll bar
set guioptions-=l
" 	Removes left hand scroll bar

"hi Conceal guibg=#2E3440  guifg=#D8DEE9
"	Corrects the color of concealed symbols in gvim according to nord-theme

autocmd GUIEnter * set vb t_vb=
"	Disables the sound in GUI when the end of the line is reached.	

" ===========
" COC OPTIONS 
" ===========

runtime .vimrc-coc-default
"	Loads the default options from [4]. Last update in September 2020.

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"	Use Tab and S-Tab to cycle throught completion	

let g:coc_snippet_next = '<c-j>'
" 	Use <C-j> for jump to next placeholder, it's default of coc.nvim

let g:coc_snippet_prev = '<c-k>'
"	Use <C-k> for jump to previous placeholder, it's default of coc.nvim

" ==============
" VIMTEX OPTIONS 
" ==============

let g:tex_flavor = 'latex'
"	Prevents detecting *.tex file as plaintex. 

"let g:tex_conceal = "abdmg"
"	Prevents automatic hiding of tex structures. 

"let g:vimtex_indent_enabled = 0
" 	Disable automatic indentation
"
" =================
" VIMTEX - QUICKFIX 
" =================
"
" let g:vimtex_quickfix_mode = 2 
"	Open the but do not focus

"let g:vimtex_quickfix_autoclose_after_keystrokes = 10 
"       Close the quickfix window after n movements

let g:vimtex_quickfix_open_on_warning = 0 
"       Do not open the quickfix window on warnings 

"let g:vimtex_quickfix_ignored_warnings = [
"    \ 'Underfull',
"    \ 'Overfull',
"    \ 'specifier changed to',
"    \ ]
"
" ====================
" VIMTEX - PDF PREVIEW
" ====================
"
let g:vimtex_view_general_viewer = 'okular'
"	Sets default pdf viewer

let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
"	Makes the reverse search work.

let g:vimtex_view_general_options_latexmk = '--unique'
"	Options required for forward search to work.

let g:vimtex_view_automatic = 0 
"	Do not open the preview automatically after compilation.
"
" ========================
" VIMTEX - PDF COMPILATION
" ========================

let g:vimtex_compiler_latexmk = {
        \ 'build_dir' : '',
        \ 'callback' : 1,
        \ 'continuous' : 1,
        \ 'executable' : 'latexmk',
        \ 'hooks' : [],
        \ 'options' : [
        \   '-verbose',
        \   '-file-line-error',
        \   '-synctex=1',
        \   '-interaction=nonstopmode',
        \ ],
        \}

" =================
" FILETYPE SPECIFIC 
" =================

"autocmd FileType tex call pencil#init({'wrap': 'soft'})
"	Initializes SoftPencil.	

"autocmd Filetype tex setlocal nofoldenable
"	Disables folding.
"
"autocmd Filetype tex setlocal conceallevel=0
"	Set conceallevel.
"
autocmd Filetype tex setlocal spell spelllang=en_us,de
"	Turn on spellcheck for TeX documents
"
" ====================
" KEY BINDINGS - GVIM
" ===================
"
" Note that noremap, inoremap, vnoremap, snoremap redefine key bindings in 
" normal, insert, visual and selection mode non-recursively (not expanding
" the new command further).

nnoremap <C-F1> :if &go=~#'m'<Bar>set go-=m<Bar>else<Bar>set go+=m<Bar>endif<CR>
nnoremap <C-F2> :if &go=~#'T'<Bar>set go-=T<Bar>else<Bar>set go+=T<Bar>endif<CR>
nnoremap <C-F3> :if &go=~#'r'<Bar>set go-=r<Bar>else<Bar>set go+=r<Bar>endif<CR>
"	Toggle menubar, toolbar and scrollbar in gvim.

" =================================
" KEY BINDINGS -- NOTEPAD IMITATION
" =================================
"
" The following adds the posibility to control vim as notepad in insert mode.
" It does not interfere with the vanila vim configuration.

snoremap <Esc> <C-g>o<C-c>
" 	Press Esc in selection mode to get back to insert mode and place the cursot at 
" 	the last character.

nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk
vnoremap <S-Up>   gk
vnoremap <S-Down> gj
" 	Arrow buttons move the cursor on soft lines

vnoremap <C-c> "+yi
vnoremap <C-x> "+d
" 	C-c and C-x in visual and selection mode copy to the system clipboard

inoremap <C-v> <Esc>"+p`]i
" 	C-v in insert mode inserts from the system clipboard

inoremap <C-z> <Esc>ui
inoremap <C-y> <Esc><c-r>i
" 	C-z and C-y in insert mode undo and redo the last change
"
inoremap <C-BS> <C-W>
"	C-BS is C-W (delete last word) in insert mode. Does not work in terminal!

" ========================
" KEY BINDINGS -- COMMENTS
" ========================

map <M-t> :call Comment()<CR>
map <M-u> :call Uncomment()<CR>
" 	Block comments.

" =====================
" KEY BINDINGS -- OTHER
" =====================

inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
"	Precc C-l to automatically correct the last spelling error. This was taken
"	from Gilles Castel's article https://castel.dev/post/lecture-notes-1/

"nnoremap <S-h> :call ToggleHiddenAll()<CR>
" 	Hide status line (because it flickers while using with coc).

" ===================
" FUNCTION - HIDE LINE
" ===================

let s:hidden_all = 0
function! ToggleHiddenAll()
    if s:hidden_all  == 0
        let s:hidden_all = 1
        set noshowmode
        set noruler
        set laststatus=0
        set noshowcmd
    else
        let s:hidden_all = 0
        set showmode
        set ruler
        set laststatus=2
        set showcmd
    endif
endfunction

" =========================
" FUNCTION - BLOCK COMMENTS
" =========================

function! Comment()
	let ft = &filetype
	if ft == 'snippets' || ft == 'conf' || ft == 'php' || ft == 'ruby' || ft == 'sh' || ft == 'make' || ft == 'python' || ft == 'perl'
		silent s/^/\#/
	elseif ft == 'javascript' || ft == 'c' || ft == 'cpp' || ft == 'java' || ft == 'objc' || ft == 'scala' || ft == 'go'
		silent s:^:\/\/:g
	elseif ft == 'tex'
		silent s:^:%:g
	elseif ft == 'vim'
		silent s:^:\":g
	endif
endfunction

function! Uncomment()
	let ft = &filetype
	if ft == 'snippets' || ft == 'conf' || ft == 'php' || ft == 'ruby' || ft == 'sh' || ft == 'make' || ft == 'python' || ft == 'perl'
		silent s/^\#//
	elseif ft == 'javascript' || ft == 'c' || ft == 'cpp' || ft == 'java' || ft == 'objc' || ft == 'scala' || ft == 'go'
		silent s:^\/\/::g
	elseif ft == 'tex'
		silent s:^%::g
	elseif ft == 'vim'
		silent! s:^\"::g
	endif
endfunction

" ========================
" FUNCTION -- MATH WRITING AND CORRECT - UNDER CONSTRUCTION!!!
" ========================

function! CorrectMath()
	set conceallevel=0
	set cursorlineopt=screenline
	set cursorline
" 		Highlight the current line. Improve to highlight just soft
" 		line!
" 	hi CursorLine guibg=#005f5f
	hi Delimiter guifg=#B48EAD
" 		Colorize the delimiters like $, {, etc.
 	VimtexToggleMain
" 		Toggle main file.
endfunction

command! CorrectMath call CorrectMath()

function! WriteMath()
" Do not use softpencil. I learned to write every sentence on a new line.
	SoftPencil
	set conceallevel=0
	set nocursorline 
"	hi Delimiter guifg=#B48EAD
	VimtexToggleMain
endfunction

command! WriteMath call WriteMath()
