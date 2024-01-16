# KurnuCat's dotfiles

## Installing the dotfiles
I recommend GNU Stow to manage the symlinks but you don't have to use it. It should be packaged with the name stow on most distributions.

Stow will automatically symlink the contents of each "package" into the parent directory from where it is invoked, that's why you should clone this repository directly into your home directory. The `--restow` parameter applies the stow command to every subdirectory in the current directory, it also restowes packages that were previously stowed.

Assuming you cloned the repo into your `~/`
```
cd ~/dotfiles
stow --restow */
```

Use stow on a single package for example bash.
```
stow bash
```

You can use the `--target` parameter if you cloned the repo elsewhere.
```
cd ~/path/to/dotfiles
stow --target=$HOME --restow */
```

If there are any conflicts delete the conflicting files.

You can also just install everything manually if you want to.

