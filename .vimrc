" ====
" TODO
" ====
"
" 1. Enable folding in tex documents in special cases like a TiKz picture
" 2. Deal with highlighting of tex syntax with nord-scheme (see 5)
" 3. Allow some concealing of tex structure, eg., italics, bold, dollar,... 
" 4. Understand Coc settings.
" 5. Set hi ctermbg ctermfg to correct nord-scheme colors.
" 6. Uderstand UltiSnips and write snippets more effectively.
" 7. Speedup the editor (what is slowing it down, UltiSnips or Coc?)
" 8. Make Tab work for both snippets and autocompletion.
"
" =====
" NOTES
" =====
"
" 1. See https://vimawesome.com/ for plugins for writers.
" 2. See https://castel.dev/post/lecture-notes-1/ for taking math notes.
"
" ========
" SETTINGS
" ========
"
" ===============================
" vim-plug --- the plugin manager
" ===============================

" using coc-snippets! Need to be installed first!

call plug#begin('~/.vim/plugged')

	Plug 'reedes/vim-pencil'

	"Plug 'preservim/nerdcommenter'

	"Plug 'ervandew/supertab'
	
	"Plug 'SirVer/ultisnips', { 'on': []} 
		"	Control snippets 
	"	let g:UltiSnipsSnippetDirectories=["UltiSnips", "my-snippets"]
	"	let g:UltiSnipsExpandTrigger = '<Tab>'
	"	let g:UltiSnipsJumpForwardTrigger = '<Tab>'
	"	let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'

	Plug 'lervag/vimtex'

	Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'tex'}

	Plug 'arcticicestudio/nord-vim'

	Plug 'neoclide/coc.nvim', {'branch': 'release'}
		" Install NodeJS. Install yarn if you want to build coc from
		" source. If there is a Javascript error on startup, try ':call
		" coc#util#install()'. 
		"
		" Run :CocInstall coc-vimtex and
		" :CocInstall coc-snippets to install the vimtex and snippets
		" plugins, respectively.
		"
		inoremap <silent><expr> <TAB>
			\ pumvisible() ? coc#_select_confirm() :
			\ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
			\ <SID>check_back_space() ? "\<TAB>" :
			\ coc#refresh()
		function! s:check_back_space() abort
  		let col = col('.') - 1
  		return !col || getline('.')[col - 1]  =~# '\s'
		endfunction
		let g:coc_snippet_next = '<tab>'
		" 	Set tab key to either pick the selected autocompletion or
		" 	evaluate a snippet. Default setting from coc website.
call plug#end()
"	Loads all plugins

" ===================
" GENERAL VIM OPTIONS
" ===================

set nocompatible
" 	Noncompativility mode --- allows Vi iMprovements even when .vimrc is
" 	present in the project directory.

filetype plugin on 
" 	Enables running specific commands when filetype is detected.

syntax on
"	Enables syntax highlighting.

set backspace=indent,eol,start
"	Modify backspace behaviour to skip over eol.

colorscheme nord
"	Set colorscheme.

"hi Conceal ctermbg=#2E3440 ctermfg=#D8DEE9
"	Correct the color of concealed symbols in vim. Correc!!

set hlsearch
"	Highlights search results

set incsearch
"	Turns on incremental searchingi, i.e., searching as typing.

set selection=inclusive
" 	Inclusive or exclusive selection. Inclusive includes the last
" 	character in the selection. However, when pasting the cursor is set to
" 	the last character, not after the pasted text.

set keymodel=startsel
"	Press shift to start selection.

set selectmode=key,mouse
" 	Selection mode is intered after pressing shift or mouse select. 

set clipboard=unnamedplus
"	Use the system's clipboard for copy-paste.

"set number
" 	Line numbering.

set wildmenu
" 	Display menu while typing a command.

set wildmode=longest:full,full
" 	Complete longest common string and then each full match

autocmd FileType json syntax match Comment +\/\/.\+$+
" 	Corrects syntax highlighting of comments in coc-config.json

" ====
" GVIM
" ====

set guifont=DejaVu\ Sans\ Mono\ 13
"	Sets font in gvim.

hi Conceal guibg=#2E3440  guifg=#D8DEE9
"	Corrects the color of concealed symbols in gvim according to nord-theme

autocmd GUIEnter * set vb t_vb=
"	Disables the annoying sound in GUI.	

" =========================
" TEX FILE SPECIFIC OPTIONS
" =========================
" This section has to be poslished!

autocmd FileType tex call pencil#init({'wrap': 'soft'})
"	Initializes SoftPencil.	

autocmd Filetype tex setlocal nofoldenable
"	Disables folding.

autocmd Filetype tex setlocal conceallevel=2
"	Set conceallevel.
"
autocmd Filetype tex setlocal spell spelllang=en_us,de
"	Spellcheck.

let g:tex_flavor = 'latex'
"	Automaticall detects *.tex file as tex. See `:h vimtex'.

let g:tex_conceal = "abdmg"
"	Prevents automatic hiding of tex structures. 

let g:vimtex_quickfix_mode=0
"	Disables quickfix

let g:vimtex_view_general_viewer = 'okular'
"	Sets default pdf viewer.

let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
let g:vimtex_view_general_options_latexmk = '--unique'
"	Options required for forward search to work. See `:h vimtex`.

let g:vimtex_quickfix_ignored_warnings = [
    \ 'Underfull',
    \ 'Overfull',
    \ 'specifier changed to',
    \ ]

" ============
" KEY BINDINGS
" ============
"
" noremap, inoremap, vnoremap, snoremap redefines key bindings in normal,
" insert, visual and selection mode non-recursively (not expanding the new
" command further).

inoremap <C-BS> <C-W>
"	Maps C-BS to C-W in insert mode. Does not work in terminal!

inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
"	Precc C-l to automatically correct the last spelling error. This was taken
"	from Gilles Castel's article https://castel.dev/post/lecture-notes-1/

map <c-t> :call Comment()<CR>
map <c-u> :call Uncomment()<CR>
" 	Block comments

nnoremap <C-F1> :if &go=~#'m'<Bar>set go-=m<Bar>else<Bar>set go+=m<Bar>endif<CR>
nnoremap <C-F2> :if &go=~#'T'<Bar>set go-=T<Bar>else<Bar>set go+=T<Bar>endif<CR>
nnoremap <C-F3> :if &go=~#'r'<Bar>set go-=r<Bar>else<Bar>set go+=r<Bar>endif<CR>
"	Appearance of menubar, toolbar and scrollbar in gvim.

snoremap <Esc> <C-g>o<C-c>
" 	Escape back to insert mode from selection mode and place the cursot at 
" 	the last character (immitates cancelling selection). The delay can be
" 	modified by setting timeoutlen=0. Isn't there a workaround? 

vnoremap <S-Up>   gk
vnoremap <S-Down> gj
" 	Modifies shift arrows to work on soft lines.

vnoremap <C-c> y<Esc>i
vnoremap <C-x> d<Esc>i
" 	Allows C-c and C-x to copy and cut, respectively, in visual and selection mode.

inoremap <C-v> <Esc>gpi
" 	Allows C-v to insert text from buffer in insert mode.

inoremap <C-z> <Esc>ui
inoremap <C-y> <Esc><c-r>i
" 	Allows C-z and C-y to undo and redo the last change in insert mode.

" ==============
" BLOCK COMMENTS
" ==============

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


