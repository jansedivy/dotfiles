alias vi='vim'
alias ios='open -a /Applications/Xcode.app/Contents/Applications/iPhone\ Simulator.app'

alias activate='d=`pwd`; $(deactivate &>/dev/null); while [ "$d" != "" ]; do [ -f "$d"/venv/bin/activate ] && echo "activating $d/venv/" && source "$d/venv/bin/activate"; d=${d%/*}; done'

alias dt='cd ~/.dotfiles'
alias dr='cd ~/Dropbox'
alias d='cd ~/Desktop'
alias e='cd ~/Dropbox/experiments'

alias gp='git push'
alias gl='git pull'
alias gap='git aa -p'

alias notes='cd ~/Dropbox/notes'

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
