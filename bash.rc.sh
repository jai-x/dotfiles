#! /usr/bin/env bash

# symlink this file to both:
#  ~/.bash_profile
#  ~/.bashrc
# and also create a ~/.bash_work.sh file for work specific config/secrets

# Add user programs to the path
if [ -d "$HOME/bin" ]; then
    export PATH="$PATH:$HOME/bin"
fi

# Import work config
if [ -f "$HOME/.bash_work.sh" ]; then
    # shellcheck source=/dev/null
    source "$HOME/.bash_work.sh"
fi

# Editor preferences
export VISUAL=nvim
export EDITOR=nvim

# Boot the startship 🚀
eval "$(starship init bash)"

# Command aliases
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    alias ls="ls --color"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    alias ls="ls -G"
else
    echo "Unknown 'ls' auto color alias for this OS"
fi

alias ll="ls -lah"

alias be="bundle exec"

alias gs="git status"
alias gb="git branch"
alias gd="git diff"

# Custom commands

# usage: 'confirm && <command to run after>'
confirm() {
    # call with a prompt string or use a default
    read -r -p "Are you sure? [y/N] " response
    case "$response" in
        [yY][eE][sS]|[yY])
            true
            ;;
        *)
            false
            ;;
    esac
}

gpl() {
    git pull --all --prune
}

gps() {
    git push "$@"
}

gpf() {
    git push --force-with-lease
}

gc() {
    if [ "$#" -gt 0 ]; then
        git checkout "$@"
        return 0
    fi

    git --no-pager branch |
    fzf --height 10 --layout reverse-list --inline-info |
    xargs git checkout
}

gbd() {
    local branch
    branch=$(
        git --no-pager branch |
        fzf --height 10 --layout reverse-list --inline-info |
        awk '{$1=$1};1'
    )

    if [ -z "$branch" ]; then
        return
    fi

    echo "Deleting branch '${branch}'"
    confirm && git branch -D "$branch"
}

GIT_PRETTY="%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue) <%an>%Creset"

gl() {
    git log --graph \
            --pretty=format:"$GIT_PRETTY" \
            --abbrev-commit \
            --date=relative
}

gll() {
    git log --graph \
            --pretty=format:"$GIT_PRETTY" \
            --abbrev-commit \
            --date=relative \
            --all
}

# Commits out of sync between current branch and the supplied branch from origin
# bd = branch diff
bd() {
    local branch
    local commits

    branch="$1"

    if [ -z "${branch}" ]; then
        echo 'error: supply branch name as first argument'
        return 1
    fi

    read -r -a commits <<< "$(git rev-list HEAD...origin/"${branch}" --left-right --count)"

    if [ -z "${commits[*]}" ]; then
        # the git command shows it's own error message
        return 1
    fi

    echo "This branch is ${commits[0]} commits ahead," \
         "${commits[1]} commits behind origin/${branch}."
}

rbserve() {
    local port

    port="${1:-9090}"

    ruby -run -e -httpd . -p "$port"
}
