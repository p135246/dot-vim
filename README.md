# Goals

1. Create an all-in-one packet which can be used to set up `vim` quickly for writing math in `LaTeX` even for lame people coming from TeXMaker, TeXStudio, etc. (like me).
2. The `select` mode of `vim` should resemble TeXMaker's behaviour as much as possible (e.g., ctrl-c, ctrl-x, ctrl-w, ctrl-z, ctrl-z, ctrl-t, ctrl-u, backspace, shift select, system buffer, ...) while the other modes should be kept intact as much as possible so that all "`vim` tricks" can be used in their standard form. (SOLVED PARTIALLY BY REMAPING VIM's KEYBINDINGS)
3. There should be a mode for *writing math* (like `:WriteMath`) which sets soft wrapping, soft pencil (I use `:SoftPencil` from `vim-pencil` plugin), concealing, snippets (`coc-snippets`), autocompletion (`coc`), etc.. for writing. There should be also a mode for *correcting math* (like `:CorrectMath`) which modifies the writing mode so that it is lighter, uses line numbering, shows commentaries, no concealing, limited autocompletion, spell checking, thesaurus, etc.. They also should set sensitivity to warnings during compilation and alter highlighing. (VERY PARTIALLY IMPLEMENTED)
4. All LaTeX writing features should work primarily in `gvim`, i.e., not necessary in terminal. The settings should be compatible with both `vim` (Vim8) and `nvim`, if one wishes to switch to the latter when a suitable GUI is available. 
5. Snippets and autocompletions should be run by external programs asynchronously so that they do not cause lags while editing. (SOLVED BY USING `coc`)
6. Forward and reverse search while compiling LaTeX documents with `latexmk` should work with `Okular`. (SOLVED)
7. There should be some basic `git` integration. (NOT IMPLEMENTED YET)
8. There should be a good compatibility with LaTeX's `subfiles` package like loading completions from all files in the project and so on. In particular, my [latex-document](https://github.com/p135246/latex-document) structure should work nicely. (SOLVED BY SPECIFYING THE `%! TEX root = ../main.tex` DIRECTIVE IN SUBFILES AND RUNNING `:VimtexToggleMain`)

# Components

1. `vim-plug`for plugin management.
2. `coc` for autocompletion (see [github](https://github.com/neoclide/coc.nvim) and [wiki](https://github.com/neoclide/coc.nvim/wiki)). It is written in JavaScript, runs asynchronously, and hence does not slow down the editor. Moreover, it has lots of extensions.
3. `coc-snippets` for snippets. This is an extension of `coc` which is compatible with lots of UltiSnips snippetsi. It is configurable by writing in `$VIMDIR/coc-settings.json`.
4. `vimtex` for latex features. I use `coc-vimtex` to optimize autocompletion with `vimtex`.

# Quick installation guide

1. Install `nodejs` (and `yarn` for building from source) for `coc` to work.

2. To achieve the best look, Install `nord-theme` for your terminal (see [nordtheme.com](https://www.nordtheme.com/ports)).

3. Create a temporary directory `temp`, change into it, and clone the repository:

   ``git clone https://github.com/p135246/dot-vim.git .``
   
3. Overwrite the user's `vim` configuration files:

   ``cp -r .vimrc .vim .config ~``

   This will also write a file `gtk.css` in `.config/gtk-3.0/` which corrects white borders around the `gvim` window which appear for some combination of fonts and screen size when the `nord-theme` is used. Note that if `gvim` was built for a different version of GTK (find it out in `vim --version`), move the file accordingly.
  
4. Run `gvim` and ignore the errors (we have not installed the components yet).

5. Pres `Esc`, type `:PlugInstall` and confirm with `Enter`. This installs the plugins. Quit by running `:q!` two times.

6. Start `gvim` again, press `Esc`, run the following commands and then quit:

    ``:call coc#util#install()``
    
    ``:CocInstall coc-json``
    
    ``:CocInstall coc-vimtex``
    
    ``:CocInstall coc-snippets``
   
   In order to view the list of installed plugins, run the following:

    ``:CocList extensions``

   If the list does not contain the plugins above, try to install them again in `vim`. If this does not help, try some standard "dumb troubleshooting" (i.e., doing something without knowing what it does precisely) like running `:CocFix`, `:CocRestart`, cleaning some directories, etc...

7. Start `gvim` again; now all plugins and extensions should work.

8. In order to make reverse search work with `Okular`, do the following. Start `Okular`, click into `Settings/Configure Okular/Editor`, change the type of the text field to `Custom text editor` and type `gvim --servername GVIM --remote +%l %f`. Click `Ok` to save the setting. Now reverse search should work by picking the`Browse Tool` and clicking somewhere while pressing shift. 

# Configuration files

1. `~/.vimrc`
2. `~/.vim/coc-settings.json`
3. `~/.vim/my-snippets/tex.snippets`
4. `~/.config/gtk-3.0/gtk.css`


# Tips and observations

## Colors and highlighting
Syntax elements, e.g., `texSpecialChar`,  are defined in `.vim/syntax/tex.vim` and relinked to global names, e.g., `SpecialChar` (if the file does not exist, copy it from a default system location). Theme colors are defined in `.vim/plugged/nord-vim/colors/nord.vim`. The pallete can be found [here.](https://www.nordtheme.com/docs/colors-and-palettes). The setting might be changed by
   
   `` :hi Delimiter ctermbg=... ctermfg=.. ``
   
   `` :hi Delimiter guibg=... guifg=... ``
   
Run `:so $VIMRUNTIME/syntax/hitest.vim` to see all color associations. Also read `:h ft-tex-syntax` for details. Display the syntax group of the current character by
   
   `` :let s = synID(line('.'), col('.'), 1) | echo synIDattr(s, 'name') . ' -> ' . synIDattr(synIDtrans(s), 'name') ``
   
This was taken from [here](https://stackoverflow.com/questions/36993988/how-can-i-find-out-the-syntax-group-of-the-current-character.)
## Snippets
* Select a text, press `<c-j>`, type the name of the snippet, e.g., `beg` and expand it. Now the `$VISUAL` variable of your snippet contains the selected text.

## Folding
* `zo`/`zc` (un)folds a group.

## Searching
* (IMPROVE!) The following command adds a hard line break after every `.`:
   `` ``
* (IMPROVE!) The following command removes unnecessary hard lines starting from the position of the cursor and ending at the end of the file:
   ``:.,$g/[^.]\n\s*/s/\n\s*/ /g``
* The following command changes `$$...$$` to `\[...\]` in the entire file:

   ``:%s/\$\$\(\_.\{-\}\)\$\$/\\\[\1\\\]/g``
   
  Meaning: `%` from beginning to end, `\_` all characters inclusing the end of the line, `.{-}` any number of the previous character (the smallest until the match of the next symbol), `g` do not apply just to the first occurence in each line (this is indeed the default behaviour) but apply to all occurences. Add `n` for a dry run or `c` to require confirmation for each match.
* newline `\r`, space `\s`
* In order to paste into the command line in normal mode, press `<c-f>'.

## My writing culture

* Each sentence on new line.
* Use `\[ \]` and not `$$ $$`.

