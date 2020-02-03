# Goals

1. The `select` mode of `vim` should resemble the TeXMaker's behaviour as much as possible while the other modes should be kept intact as much as possible. 
2. There should be a mode for *writing math* in tex (like `:WriteMath`) which sets reasonable soft pencil, concealing, snippets, autocompletion, etc.. There should be a mode for *correcting math* in tex which set which modifies the writing mode.
3. The settings should be compatible for both `vim` (Vim8) and `nvim`. All features should work in `gvim`.
4. Snippets and autocompletions should be run by external programs asynchronously so that they do not cause lags while editing.
5. Forward and reverse search while editing LaTeX documents should work with `Okular`.

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

7. Starting `gvim` again, now everything should work.


# Configuration files

1. `~/.vimrc'
2. `~/.vim/coc-settings.json`
3. `~/.vim/my-snippets/vim.snippets`
