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
