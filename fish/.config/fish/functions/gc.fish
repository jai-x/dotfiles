function gc --wraps='git checkout'
  if test (count $argv) -eq 0
    set -l branch (
      git --no-pager branch |
      fzf --height 10 --layout reverse-list --inline-info --header 'Checkout which branch?'
    )
    if not test -z $branch
      git checkout (string trim (string trim --chars='*' $branch))
    else
      echo 'No branch selected'
    end
  else
    git checkout $argv
  end
end
