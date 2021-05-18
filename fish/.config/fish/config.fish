# Remove default fish message
set -U fish_greeting

# Editor preferences
set -x VISUAL nvim
set -x EDITOR nvim

# Boot the starship 🚀
if type -q starship
	starship init fish | source
else
	echo 'starship is not installed, please install starship'
end

if test -d "$HOME/bin"
	fish_add_path "$HOME/bin"
end
