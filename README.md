# Goals

1. For tex files, the insert mode should precisely as TexMaker. These commands should end up in the insert mode afer their execution and the cursor position should correspond to the TexMaker's behaviour.
      * <C-C>: copy
      * <C-V>: paste
      * <C-XYZTU>
2. The normal mode should not be altered too much, in particular, the default keybindings should remain.
3. It should be possible to cancel expansion of a snippet and continue writing.
4. Math environments should be concealed.
5. Brackets should be autocompleted cleverly.

Difference: Pressing <C-Right> at the last word skips to the beginning of the first word of the new line. TexMaker skips to the end of the word first. Can be possibly corrected by telling vim to treat he end of line as a word.

6. In the normal mode, all keybindings should be the default ones. Also, e.g., selection of text!
7. There should be a mode for *writing* of latex files (concealing, snippets, autocompletion) and for *correcting* of latex files (dictionary, thesaurus, no concealing, no snippets, restricted autocompletion).

# Components

1. `coc` for autocompletion (see [github](https://github.com/neoclide/coc.nvim) and [wiki](https://github.com/neoclide/coc.nvim/wiki)): Written in JavaScript. Runs asynchronously, hence does not slow down the editor. It is possible to add extensions.
2. `coc-snippets` for snippets: Extension of `coc` which is compatible with lots of UltiSnips snippets.

# Quick installation guide

1. Make sure that the newest version of `vim` (Vim8) is installed. Install `nodejs` and `yarn` for the autocompletion with `coc` to work (possibly more java related files is needed; not checked!). In order to achieve the best look, make sure that your terminal uses the `nord` theme (go to [nordtheme.com](https://www.nordtheme.com/ports) to configure your applications). Use `gvim` for all the tweeks to work.


2. In some temporary directory `temp` run

   ``git clone https://github.com/p135246/dot-vim.git .``
   
   to clone the repository.
3. In the directory `temp`, run

   ``cp -r .vimrc .vim ~``
   
   to copy the files to your home directory.
4. Run `gvim` (some errors related to configuration files, autocompletion and plugins might appear --- just ignore them and click through). In the normal mode of `vim` (pressing `ESC`), run

    ``:PlugInstall``
    
    to install the plugins. Then quit by running `:q!`.
5. To make the autocompletion `coc` work, run

    ``:call coc#util#install()``
    
    ``:CocInstall coc-json``
    
    ``:CocInstall coc-vimtex``
    
    Rerun `gvim`, now everything should work.
