# symlink this file to:
#  ~/.config/fish/config.fish

# Remove default fish message
set -U fish_greeting

# Editor preferences
set -x VISUAL nvim
set -x EDITOR nvim

# Boot the starship 🚀
starship init fish | source

if test -d "$HOME/bin"
	fish_add_path "$HOME/bin"
end
