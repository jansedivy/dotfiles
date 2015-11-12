autoload colors && colors

if (( $+commands[git] ))
then
  git="$commands[git]"
else
  git="/usr/bin/git"
fi

git_dirty() {
  st=$($git status 2>/dev/null | tail -n 1)
  if [[ $st == "" ]]
  then
    echo ""
  else
    if [[ "$st" =~ ^nothing ]]
    then
      echo "(%{$fg_bold[green]%}$(git_prompt_info)%{$reset_color%}$(need_push))"
    else
      echo "(%{$fg_bold[red]%}$(git_prompt_info)%{$reset_color%}$(need_push))"
    fi
  fi
}

git_prompt_info () {
 ref=$($git symbolic-ref HEAD 2>/dev/null) || return
 echo "${ref#refs/heads/}"
}

unpushed () {
  $git cherry -v @{upstream} 2>/dev/null
}

need_push () {
  if [[ $(unpushed) == "" ]]
  then
    echo ""
  else
    echo "%{$fg_bold[blue]%}!%{$reset_color%}"
  fi
}

vim_jobs_count() {
  count=`echo $(jobs | grep vim | wc -l)`
  if [ $count -ne "0" ]
  then
    echo "%{$fg_bold[green]%}`echo $(jot -b ! $count) | sed 's/ //g'`%{$reset_color%}"
  fi
}

directory_name() {
  echo "%{$fg_bold[blue]%}%1/%{$reset_color%}"
}

export PROMPT=$'$(vim_jobs_count)$(directory_name)$(git_dirty) › '
