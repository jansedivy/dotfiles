autoload colors && colors
# cheers, @ehrenmurdick
# http://github.com/ehrenmurdick/config/blob/master/zsh/prompt.zsh

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

jobs_count() {
  count=`echo $(jobs | wc -l)`
  if [ $count -ne "0" ]
  then
    echo "$count:"
  fi
}

directory_name(){
  echo "%{$fg_bold[cyan]%}%1/%{$reset_color%}"
}

export PROMPT=$'$(jobs_count)$(directory_name)$(git_dirty) › '
