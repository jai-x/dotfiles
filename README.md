# dotfiles

For future me when setting up

### Dependencies

For installation:
* [git](https://git-scm.com/)
* [stow](https://www.gnu.org/software/stow/)

For config `neovim`:
* [neovim](https://neovim.io)
* [ripgrep](https://github.com/BurntSushi/ripgrep)

For config `bash`:
* [bash](https://www.gnu.org/software/bash/)
* [starship](https://starship.rs/)
* [fzf](https://github.com/junegunn/fzf)

For config `fish`:
* [fish](https://fishshell.com/)
* [starship](https://starship.rs/)

### Installation

Use `stow` to link each programs config with the home directory as the target.
For example, to setup the neovim symlinks:
```shell
> stow -t ~ neovim
```
