# Remove default fish message
set -U fish_greeting

# Editor preferences
set -x VISUAL nvim
set -x EDITOR nvim

# Add custom programs
if test -d "$HOME/bin"
	fish_add_path "$HOME/bin"
end

# Add machine specific config
if test -e ~/.config/fish/specific.fish
	source ~/.config/fish/specific.fish
end

# Boot the starship 🚀
if type -q starship
	starship init fish | source
else
	echo 'starship is not installed, please install starship'
end

# Add asdf
if test -e ~/.asdf/asdf.fish
	source ~/.asdf/asdf.fish
else
	echo 'asdf is not installed, please install asdf'
end

# Ensure fzf is present
if not type -q fzf
  echo 'fzf is not installed, please install fzf'
end
