# dotfiles

For future me when setting up

### Dependencies

* [git](https://git-scm.com/)
* [neovim](https://neovim.io) with [vim-plug](https://github.com/junegunn/vim-plug) configured
* [ripgrep](https://github.com/BurntSushi/ripgrep)
* [fzf](https://github.com/junegunn/fzf)
* [stow](https://www.gnu.org/software/stow/)

### Installation

Use `stow` to link each programs config with the home directory as the target.
For example, to setup the neovim symlinks:
```shell
> stow -t ~ neovim
```
