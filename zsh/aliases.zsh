alias aliases='vim ~/.dotfiles/zsh/aliases.zsh'
alias d='cd ~/Documents/scratch/'
alias dt='cd ~/.dotfiles'
alias u='cd ..'
alias vi='nvim'
alias vim='nvim'

function g() {
  if [[ $# > 0 ]]; then
    git $@
  else
    git status
  fi
}

if $(gls &>/dev/null)
then
  alias ls="gls -F --color"
  alias l="gls -lAh --color"
  alias ll="gls -l --color"
  alias la='gls -A --color'
fi
