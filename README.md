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
* [asdf](https://asdf-vm.com/) (Always install manually via git as packaged versions are often broken)
* [fzf](https://github.com/junegunn/fzf)

For config `karabiner`:
* [karabiner-elements](https://karabiner-elements.pqrs.org/)

### Installation

Use `stow` to link each programs config with the home directory as the target.
For example, to setup the neovim symlinks:
```shell
> stow -t ~ neovim
```
