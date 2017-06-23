# Dotfiles Management Repository

This document sumerizes my methodology to version my config files (it is based on [this post](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/)). 

Fisrt let's create a custom configuration directory (in `$HOME/` dir) to store the repository with the dotfiles in it.
 
* The first line creates a folder `~/.cfg` which is a Git bare repository that will track our files.
* Then we create an alias config which we will use instead of the regular git when we want to interact with our configuration repository.
* We set a flag - local to the repository - to hide files we are not explicitly tracking yet. This is so that when you type config status and other commands later, files you are not interested in tracking will not show up as untracked.
* Also you can add the alias definition by hand to your .bashrc or use the the fourth line provided for convenience.

```
$ git init --bare $HOME/.cfg
$ alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
$ config config --local status.showUntrackedFiles no
$ echo "alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'" >> $HOME/.bashrc
```

We can get an error if there is already a configuration repository within the $HOME directory. To fix this we can instead execute the below commands saving the repo into a temporary directory and then deleting it after copying.

* The first line copies the repository to the `$HOME/.cfg-tmp` directory.
* Then we copy the temporary directory to the original `$HOME/.cfg`.
* Delete the temporary files after restoring to the original configuration directory.
* Continue the above workflow to get your dotfiles configuration up.

```
$ git clone --separate-git-dir=$HOME/.cfg /path/to/repo $HOME/.cfg-tmp
$ cp ~/.cfg-tmp/.gitmodules ~  # If you use Git submodules
$ rm -r ~/.cfg-tmp/
$ alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
$ config config --local status.showUntrackedFiles no
$ echo "alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'" >> $HOME/.bashrc
```
After the configuration above has been executed all files within the $HOME folder could be versioned with all git commands, replacing git with the `config` alias, like:

```
$ config status
$ config add .vimrc
$ config commit -m "Add vimrc"
$ config add .bashrc
$ config commit -m "Add bashrc"
$ config push
```

## Module Configuration

Below we have per module configurations (I call them modules because i did not know another good name to give) needed before being able to fully utilize the files in the repository. Each item demonstrates the necessary commands:

1. To configure `vim` we need to install the plugin manager (here we use the VimPlug manager).

```
$ curl -fLo ~/.vim/autoload/plug.vim --create-dirs \ 
$     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
$ ~inside vim~ :PlugInstall
```
