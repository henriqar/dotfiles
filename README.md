

# Dotfiles Management Repository

Gathered within this repository is all configuration files (dotfiles) that I use on a daily basis (or used at some point in time). A Makefile composed of different targets was written to facilitate the installation (and removal) of each dotfile. All available targets are listed below.

|target|description|
|------|-----------|
| `install_vim` | install `.vimrc`, `.vim/` folder, and some `ftplugin` stuff |
| `force_install_vim` | force installation of `vim` stuff, even if already exists |
| `clean_vim` | remove all files related to the `vim` installation |
| `install_tmux` | installs `.tmux.conf` file |
| `force_install_tmux` | force installation of `.tmux.conf` |
| `clean_tmux` | remove `.tmux.conf` file installed |
| `install_screen` | installs `.screenrc` file |
| `force_install_screen` | force installation of `.screenrc` file |
| `clean_screen` | remove `.screenrc` file |
| `install_gitconfig` | installs `.gitconfig` file |
| `force_install_gitconfig` | forces installation of `.gitconfig` file |
| `clean_gitconfig` | remove `.gitconfig` file |
| `install_all` | install all targets available (`gitconfig`, `vim`, `tmux`, and `screen`)|
| `clean_all` | remove all dotfiles related to (`gitconfig`, `vim`, `tmux`, and `screen`)|

## Additional Steps

After running all necessary targets, one must execute some internal tool commands to setup the final environment. Targets `vim` and `tmux` need to install a different set of internal plugins.

### Vim

Execute `vim` for the fisrt time and run `:PlugInstall` to install all plugins defined in `.vimrc` file and restart `vim` after it is done.

### Tmux

Execute `tmux` for the first time and run `<prefix> + I` to install `tmux` plugin manager and restart `tmux` after it is done.
