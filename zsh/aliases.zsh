alias aliases='vim ~/.dotfiles/zsh/aliases.zsh'
alias d='cd ~/Documents/scratch/'
alias dr='cd ~/Dropbox\ \(Personal\)'
alias dt='cd ~/.dotfiles'
alias dw='cd ~/Downloads'
alias so='source ~/.dotfiles/zsh/aliases.zsh'
alias u='cd ..'
alias vi='nvim'
alias vim='nvim'

alias dc='docker-compose'

alias v7='cd ~/Documents/scratch/invision/invision-local && docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q) && ./utils/run.sh setup edge-gateway=all offline && docker-compose up -d'
alias v6='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q) && in setup && in start freehand'

alias keyoff='sudo kextunload /System/Library/Extensions/AppleUSBTopCase.kext/Contents/PlugIns/AppleUSBTCKeyboard.kext/'
alias keyon='sudo kextload /System/Library/Extensions/AppleUSBTopCase.kext/Contents/PlugIns/AppleUSBTCKeyboard.kext/'

alias fh='open $(curl -X POST "https://freehand-api.invisionapp.com/api/documents/create" -s | jq ".url" -r)'

venv () {
  . $(up .env)
}

activate() {
  if [ -f venv/bin/activate ]; then . venv/bin/activate;
  elif [ -f ../venv/bin/activate ]; then . ../venv/bin/activate;
  elif [ -f ../../venv/bin/activate ]; then . ../../venv/bin/activate;
  elif [ -f ../../../venv/bin/activate ]; then . ../../../venv/bin/activate;
  fi
}

function up() {
  local DIR=$PWD
  local TARGET=$1
  while [ ! -e $DIR/$TARGET -a $DIR != "/" ]; do
    DIR=$(dirname $DIR)
  done
  test $DIR != "/" && echo $DIR/$TARGET
}

function g() {
  if [[ $# > 0 ]]; then
    git $@
  else
    git status
  fi
}

function mcd() { mkdir -p $1 && cd $1 }
function cdf() { cd *$1*/ }

function gif_video() {
  ffmpeg -i "$1" -s 600x400 -pix_fmt rgb24 -r 10 -f gif - | gifsicle --optimize=3 --delay=3 > out.gif
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

function dcleanup() {
  docker rm -v $(docker ps --filter status=exited -q 2>/dev/null) 2>/dev/null
  docker rmi $(docker images --filter dangling=true -q 2>/dev/null) 2>/dev/null
}
