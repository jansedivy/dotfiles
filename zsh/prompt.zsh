autoload colors && colors

if (( $+commands[git] ))
then
  git="$commands[git]"
else
  git="/usr/bin/git"
fi

git_prompt() {
  git rev-parse --is-inside-work-tree &>/dev/null || return

  git diff --quiet --ignore-submodules HEAD &>/dev/null
  if [[ $? -eq 0 ]]
  then
    echo "(%{$fg_bold[green]%}$(git_prompt_branch)%{$reset_color%}$(need_push))"
  else
    echo "(%{$fg_bold[red]%}$(git_prompt_branch)%{$reset_color%}$(need_push))"
  fi
}

git_prompt_branch() {
 ref=$($git symbolic-ref HEAD 2>/dev/null) || return
 echo "${ref#refs/heads/}"
}

unpushed() {
  $git cherry -v @{upstream} 2>/dev/null
}

need_push() {
  if [[ $(unpushed) == "" ]]
  then
    echo ""
  else
    echo "%{$fg_bold[blue]%}!%{$reset_color%}"
  fi
}

vim_jobs_count() {
  count=`echo $(jobs | wc -l)`
  if [ $count -ne "0" ]
  then
    echo "%{$fg_bold[green]%}`echo $(jot -b ! $count) | sed 's/ //g'`%{$reset_color%}"
  fi
}

directory_name() {
  echo "%{$fg_bold[blue]%}%1/%{$reset_color%}"
}

export PROMPT=$'$(vim_jobs_count)$(directory_name)$(git_prompt) › '
