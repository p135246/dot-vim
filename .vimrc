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

call plug#begin('~/.vim/plugged')

	Plug 'reedes/vim-pencil'

	"Plug 'preservim/nerdcommenter'

	"Plug 'ervandew/supertab'
	
	Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
		let g:UltiSnipsExpandTrigger = '<Tab>'
		let g:UltiSnipsJumpForwardTrigger = '<Tab>'
		let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'
		"	Control snippets 
		let g:UltiSnipsSnippetDirectories=["UltiSnips", "my-snippets"]

	Plug 'lervag/vimtex'

	Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'tex'}

	Plug 'arcticicestudio/nord-vim'

	Plug 'neoclide/coc.nvim'
	     " Use <Tab> and <S-Tab> for navigate completion list                            
		inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Down>"
		inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<Up>"
		inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
		" If Javascript error on startup, try  `:call
		" coc#util#install()`. Also run ':CocInstall coc-vimtex'
 		" let g:SuperTabDefaultCompletionType = '<C-n>'
		autocmd FileType json syntax match Comment +\/\/.\+$+
		" Corrects syntax highlighting of comments in coc-config.json
call plug#end()
"	Loads all plugins

" ===
" vim
" ===


set nocompatible
" 	Noncompativility mode --- allows Vi iMprovements even when .vimrc is
" 	present in the project directory.

filetype plugin on 
" 	Enables running specific commands when filetype is detected.

syntax on
"	Enables syntax highlighting.

set backspace=indent,eol,start
"	Backspace behaviour.

colorscheme nord
"	Set colorscheme.

"hi Conceal ctermbg=#2E3440 ctermfg=#D8DEE9
"	Correct the color of concealed symbols in vim.

inoremap <C-BS> <C-W>
"	Maps C-BS to C-W in insert mode. Does not work in terminal!

inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
"	Precc C-l to automatically correct the last spelling error (due to
"	Gilles Castel)

set hlsearch
"	Highlights search results

set incsearch
"	Turns on incremental searchingi, i.e., searching as typing.

"nnoremap <Esc><Esc> :noh<CR><CR>

set selection=exclusive
set keymodel=startsel,stopsel
"	Select text while holding shift, cancel selection by releasing shift
"	and pressing an other key. 

vnoremap <S-Up>   gk
vnoremap <S-Down> gj
imap     <S-Up>   <Esc>gh<S-Up>
imap     <S-Down> <Esc><Right>gh<S-Down>
nmap     <S-Up>   gh<S-Up>
nmap     <S-Down> gh<S-Down>
"	Corrects the behaviour of shift up, shift down on soft lines.
"	Depending on the behaviour of k, j (set by vim-pencil), they
"	move one soft line up and down. 	
" shift+arrow selection
"nmap <S-Up> v<Up>
"nmap <S-Down> v<Down>
"nmap <S-Left> v<Left>
"nmap <S-Right> v<Right>
"vmap <S-Up> <Up>
"vmap <S-Down> <Down>
"vmap <S-Left> <Left>
"vmap <S-Right> <Right>
"imap <S-Up> <Esc>v<Up>
"imap <S-Down> <Esc>v<Down>
"imap <S-Left> <Esc>v<Left>
"imap <S-Right> <Esc>v<Right>
vmap <C-c> y<Esc>i
vmap <C-x> d<Esc>i
"map <C-v> pi
imap <C-v> <Esc>gpi
imap <C-z> <Esc>ui
imap <C-Y> <Esc><C-R>i
"	Redo moves the cursor to another position. Correct!
" <C-O> runs single normal mode command while remaining in insert mode.

set clipboard=unnamedplus
"	Use the system's clipboard for copy-paste.

imap <C-Right> <C-Right>

set number

" ====
" gvim
" ====

nnoremap <C-F1> :if &go=~#'m'<Bar>set go-=m<Bar>else<Bar>set go+=m<Bar>endif<CR>
nnoremap <C-F2> :if &go=~#'T'<Bar>set go-=T<Bar>else<Bar>set go+=T<Bar>endif<CR>
nnoremap <C-F3> :if &go=~#'r'<Bar>set go-=r<Bar>else<Bar>set go+=r<Bar>endif<CR>
"	Constrols appearance of menubar, toolbar and scrollbar.
"	C-F1:	Toggle 
set guifont=DejaVu\ Sans\ Mono\ 13
"	Sets font in gvim.

hi Conceal guibg=#2E3440  guifg=#D8DEE9
"	Corrects the color of concealed symbols according to nord-theme

autocmd GUIEnter * set vb t_vb=
"	Disables the annoying sound in GUI.	

" ==================
" tex files specific
" ==================

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

map <c-t> :call Comment()<CR>
map <c-u> :call Uncomment()<CR>

function! Comment()
	let ft = &filetype
	if ft == 'php' || ft == 'ruby' || ft == 'sh' || ft == 'make' || ft == 'python' || ft == 'perl'
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
	if ft == 'php' || ft == 'ruby' || ft == 'sh' || ft == 'make' || ft == 'python' || ft == 'perl'
		silent s/^\#//
	elseif ft == 'javascript' || ft == 'c' || ft == 'cpp' || ft == 'java' || ft == 'objc' || ft == 'scala' || ft == 'go'
		silent s:^\/\/::g
	elseif ft == 'tex'
		silent s:^%::g
	elseif ft == 'vim'
		silent! s:^\"::g
	endif
endfunction


" ==============
" BLOCK COMMENTS
" ==============
" source: https://stackoverflow.com/a/24046914/2571881

" =====================
" RECOMMENDED COC OPTION
" ======================
"
"" if hidden is not set, TextEdit might fail.
"set hidden
"
"" Some servers have issues with backup files, see #649
"set nobackup
"set nowritebackup
"
"" Better display for messages
"set cmdheight=2
"
"" You will have bad experience for diagnostic messages when it's default 4000.
"set updatetime=300
"
"" don't give |ins-completion-menu| messages.
"set shortmess+=c
"
"" always show signcolumns
"set signcolumn=yes
"
"" Use tab for trigger completion with characters ahead and navigate.
"" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
"inoremap <silent><expr> <TAB>
"      \ pumvisible() ? "\<C-n>" :
"      \ <SID>check_back_space() ? "\<TAB>" :
"      \ coc#refresh()
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"
"function! s:check_back_space() abort
"  let col = col('.') - 1
"  return !col || getline('.')[col - 1]  =~# '\s'
"endfunction
"
"" Use <c-space> to trigger completion.
"inoremap <silent><expr> <c-space> coc#refresh()
"
"" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
"" Coc only does snippet and additional edit on confirm.
"inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"" Or use `complete_info` if your vim support it, like:
"" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
"
"" Use `[g` and `]g` to navigate diagnostics
"nmap <silent> [g <Plug>(coc-diagnostic-prev)
"nmap <silent> ]g <Plug>(coc-diagnostic-next)
"
"" Remap keys for gotos
"nmap <silent> gd <Plug>(coc-definition)
"nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
"nmap <silent> gr <Plug>(coc-references)
"
"" Use K to show documentation in preview window
"nnoremap <silent> K :call <SID>show_documentation()<CR>
"
"function! s:show_documentation()
"  if (index(['vim','help'], &filetype) >= 0)
"    execute 'h '.expand('<cword>')
"  else
"    call CocAction('doHover')
"  endif
"endfunction
"
"" Highlight symbol under cursor on CursorHold
"autocmd CursorHold * silent call CocActionAsync('highlight')
"
"" Remap for rename current word
"nmap <leader>rn <Plug>(coc-rename)
"
"" Remap for format selected region
"xmap <leader>f  <Plug>(coc-format-selected)
"nmap <leader>f  <Plug>(coc-format-selected)
"
"augroup mygroup
"  autocmd!
"  " Setup formatexpr specified filetype(s).
"  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
"  " Update signature help on jump placeholder
"  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
"augroup end
"
"" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
"xmap <leader>a  <Plug>(coc-codeaction-selected)
"nmap <leader>a  <Plug>(coc-codeaction-selected)
"
"" Remap for do codeAction of current line
"nmap <leader>ac  <Plug>(coc-codeaction)
"" Fix autofix problem of current line
"nmap <leader>qf  <Plug>(coc-fix-current)
"
"" Create mappings for function text object, requires document symbols feature of languageserver.
"xmap if <Plug>(coc-funcobj-i)
"xmap af <Plug>(coc-funcobj-a)
"omap if <Plug>(coc-funcobj-i)
"omap af <Plug>(coc-funcobj-a)
"
"" Use <TAB> for select selections ranges, needs server support, like: coc-tsserver, coc-python
"nmap <silent> <TAB> <Plug>(coc-range-select)
"xmap <silent> <TAB> <Plug>(coc-range-select)
"
"" Use `:Format` to format current buffer
"command! -nargs=0 Format :call CocAction('format')
"
"" Use `:Fold` to fold current buffer
"command! -nargs=? Fold :call     CocAction('fold', <f-args>)
"
"" use `:OR` for organize import of current buffer
"command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
"
"" Add status line support, for integration with other plugin, checkout `:h coc-status`
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
"
"" Using CocList
"" Show all diagnostics
"nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
"" Manage extensions
"nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
"" Show commands
"nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
"" Find symbol of current document
"nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
"" Search workspace symbols
"nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
"" Do default action for next item.
"nnoremap <silent> <space>j  :<C-u>CocNext<CR>
"" Do default action for previous item.
"nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
"" Resume latest coc list
"nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
