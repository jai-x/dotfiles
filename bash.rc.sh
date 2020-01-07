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
    source "$HOME/.bash_work.sh"
fi

# Editor preferences
export VISUAL=nvim
export EDITOR=nvim

# Prompt setup
GREEN="$(tput setaf 2)"
RED="$(tput setaf 3)"
BLUE="$(tput setaf 4)"
MAGENTA="$(tput setaf 5)"
CYAN="$(tput setaf 6)"
WHITE="$(tput setaf 7)"
RESET="$(tput sgr0)"

color_test() {
    echo "${GREEN}GREEN   GREEN   GREEN  ${RESET}"
    echo "${RED}RED     RED     RED    ${RESET}"
    echo "${BLUE}BLUE    BLUE    BLUE   ${RESET}"
    echo "${MAGENTA}MAGENTA MAGENTA MAGENTA${RESET}"
    echo "${CYAN}CYAN    CYAN    CYAN   ${RESET}"
    echo "${WHITE}WHITE   WHITE   WHITE  ${RESET}"
}

random_color() {
    local COLORS=($GREEN $RED $BLUE $MAGENTA $CYAN $WHITE)
    local SIZE=${#COLORS[@]}
    local INDEX=$(($RANDOM % $SIZE))
    echo ${COLORS[$INDEX]}
}

prompt_branch() {
    local BRANCH="$(git branch 2>/dev/null | awk '/\*/ { print $2 }')"
    if [ -n "$BRANCH" ]; then

        local DIRTY=""
        if [ -n "$(git status --porcelain 2>/dev/null)" ]; then
            DIRTY=" +"
        fi

        echo "(${GREEN}${BRANCH}${DIRTY}${RESET}) "
    fi
}

export PS1="${BLUE}\w${RESET} \$(prompt_branch)\n\$(random_color)λ${RESET} "
export PS2="> "

# Command aliases
alias ls="ls --color"
alias ll="ls -lah"

alias be="bundle exec"

alias gs="git status"
alias gb="git branch"
alias gd="git diff"

# Custom commands

# usage: confirm '<optional message>' && command to run after
confirm() {
    # call with a prompt string or use a default
    read -r -p "${1:-Are you sure? [y/N]} " response
    case "$response" in
        [yY][eE][sS]|[yY])
            true
            ;;
        *)
            false
            ;;
    esac
}

gp() {
    git pull --all --prune
}

gpf() {
    git push --force-with-lease
}

gc() {
    git --no-pager branch |
    fzf --height 10 --layout reverse-list --inline-info |
    xargs git checkout
}

gbd() {
    local branch=$(
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
