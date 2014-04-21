# Use `hub` as our git wrapper:
#   http://defunkt.github.com/hub/
hub_path=$(which hub)
if [[ -f $hub_path ]]
then
  alias git=$hub_path
fi

alias review='git diff master'
alias gp='git push'
alias amend='git commit --amend'
alias gap='git add --all -p'
