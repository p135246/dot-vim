# Goals

1. Create an all-in-one packet which can be used to set up `vim` quickly for writing math in `LaTeX` even for lame people coming from TeXMaker, TeXStudio, etc. (like me).
2. The `select` mode of `vim` should resemble TeXMaker's behaviour as much as possible (e.g., ctrl-c, ctrl-x, ctrl-w, ctrl-z, ctrl-z, ctrl-t, ctrl-u, backspace, shift select, system buffer, ...) while the other modes should be kept intact as much as possible so that all "`vim` tricks" can be used in their standard form. (SOLVED PARTIALLY BY REMAPING VIM's KEYBINDINGS)
3. There should be a mode for *writing math* (like `:WriteMath`) which sets up soft wrapping, soft pencil (I use `:SoftPencil` from `vim-pencil` plugin), concealing, snippets (`coc-snippets`), autocompletion (`coc`), etc.. for writing. There should be also a mode for *correcting math* (like `:CorrectMath`) which modifies the writing mode so that it is lighter, uses line numbering, shows commentaries, no concealing, limited autocompletion, spell checking, thesaurus, etc.. (PARTIALLY IMPLEMENTED, BUT NO SUCH COMMANDS EXIST YET)
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
3. `~/.vim/my-snippets/vim.snippets`
4. `~/.config/gtk-3.0/gtk.css`
