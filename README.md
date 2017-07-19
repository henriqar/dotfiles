# Dotfiles Management Repository

This document sumerizes my methodology to version my configuration files (it is based on [this post](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/)). 

Before starting the procedure we need to setup the plugin manager used with this `.vimrc`.

## Plugin Manager Installation

To configure `vim` we need to install the plugin manager (here we use the VimPlug manager).

```
$ curl -fLo ~/.vim/autoload/plug.vim --create-dirs \ 
$     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

## Building the Configuration Bare Repository

First we need to associate the bare repository to the alias used to configure the `$HOME` repository:

```
$ alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
```

Now we clone the dotfiles to the bare repository assigned to it:

```
$ git clone --bare https://github.com/R3bs/dotfiles $HOME/.cfg
```

Set the git status to not show untracked files (because there is a lot of files inside ther `$HOME` and it would pollute the information shown).

```
$ config config --local status.showUntrackedFiles no
```

Checkout the remote repo content to the bare repo we are using in `$HOME`:

```
$ config checkout
```

At this moment an error can occur indicating something as:

```
$ error: The following untracked working tree files would be overwritten by checkout:
$     .bashrc
$     .gitignore
$ Please move or remove them before you can switch branches.
$ Aborting
```
This is because your `$HOME` folder might already have some stock configuration files which would be overwritten. 

The solution is simple: back up the files or remove them.

After the configuration above has been executed all files within the `$HOME` folder could be versioned with all git commands, replacing git with the `config` alias, like:

```
$ config status
$ config add .vimrc
$ config commit -m "Add vimrc"
$ config add .bashrc
$ config commit -m "Add bashrc"
$ config push
```

But remember that you will be versioning this files inside the bare repository. This will not push automatically to the remote git repository (you will need to take care of this step).
