alias activate='d=`pwd`; $(deactivate &>/dev/null); while [ "$d" != "" ]; do [ -f "$d"/venv/bin/activate ] && echo "activating $d/venv/" && source "$d/venv/bin/activate"; d=${d%/*}; done'

alias aliases='vim ~/.dotfiles/zsh/aliases.zsh'
alias amend='git commit --amend'
alias b='brew'
alias bi='brew install'
alias bu='brew update && brew upgrade'
alias d='cd ~/Desktop'
alias dev='cd ~/Dropbox/dev'
alias dr='cd ~/Dropbox'
alias drop='cd ~/Dropbox'
alias dt='cd ~/.dotfiles'
alias exp='cd ~/Dropbox/experiments'
alias gap='git add --all -p'
alias gcl='git clone'
alias gco='git checkout'
alias gl='gulp'
alias gp='git push'
alias ios='open -a /Applications/Xcode.app/Contents/Applications/iPhone\ Simulator.app'
alias n='npm'
alias ni='npm install'
alias notes='cd ~/Dropbox/notes'
alias review='git diff master'
alias so='source ~/.dotfiles/zsh/aliases.zsh'
alias u='cd ..'
alias vi='vim'

function g {
   if [[ $# > 0 ]]; then
     git $@
   else
     git status
   fi
}

# grc overides for ls
#   Made possible through contributions from generous benefactors like
#   `brew install coreutils`
if $(gls &>/dev/null)
then
  alias ls="gls -F --color"
  alias l="gls -lAh --color"
  alias ll="gls -l --color"
  alias la='gls -A --color'
fi
