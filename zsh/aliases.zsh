alias aliases='vim ~/.dotfiles/zsh/aliases.zsh'
alias b='brew'
alias bi='brew install'
alias bu='brew update && brew upgrade'
alias d='cd ~/Desktop'
alias dr='cd ~/Dropbox'
alias drop='cd ~/Dropbox'
alias dt='cd ~/.dotfiles'
alias exp='cd ~/Dropbox/experiments'
alias gl='gulp'
alias ios='open -a /Applications/Xcode.app/Contents/Applications/iPhone\ Simulator.app'
alias n='npm'
alias ni='npm install'
alias nt='npm test'
alias so='source ~/.dotfiles/zsh/aliases.zsh'
alias u='cd ..'
alias vi='vim'
alias v='view -'

alias keyoff='sudo kextunload /System/Library/Extensions/AppleUSBTopCase.kext/Contents/PlugIns/AppleUSBTCKeyboard.kext/'
alias keyon='sudo kextload /System/Library/Extensions/AppleUSBTopCase.kext/Contents/PlugIns/AppleUSBTCKeyboard.kext/'

# alias notes='cd ~/Dropbox/notes'

activate_virtualenv() {
    if [ -f env/bin/activate ]; then . env/bin/activate;
    elif [ -f ../env/bin/activate ]; then . ../env/bin/activate;
    elif [ -f ../../env/bin/activate ]; then . ../../env/bin/activate;
    elif [ -f ../../../env/bin/activate ]; then . ../../../env/bin/activate;
    fi
}

function p() {
    dev=$(ls ~/Dropbox/dev --color=never | selecta)
    if [[ -n "$dev" ]]; then
        cd ~/Dropbox/dev/$dev
    fi
}

function notes {
    note=$(ls ~/Dropbox/notes --color=never | selecta)
    if [[ -n "$note" ]]; then
        cd ~/Dropbox/notes/$note
    fi
}

function up ()
{
    if [ "$1" != "" -a "$2" != "" ]; then
        local DIR=$1
        local TARGET=$2
    elif [ "$1" ]; then
        local DIR=$PWD
        local TARGET=$1
    fi
    while [ ! -e $DIR/$TARGET -a $DIR != "/" ]; do
        DIR=$(dirname $DIR)
    done
    test $DIR != "/" && echo $DIR/$TARGET
}

function g {
   if [[ $# > 0 ]]; then
     git $@
   else
     git status
   fi
}

# By default, ^S freezes terminal output and ^Q resumes it. Disable that so
# that those keys can be used for other things.
unsetopt flowcontrol
# Run Selecta in the current working directory, appending the selected path, if
# any, to the current command.
function insert-selecta-path-in-command-line() {
    local selected_path
    # Print a newline or we'll clobber the old prompt.
    echo
    # Find the path; abort if the user doesn't select anything.
    selected_path=$(find * -type f | selecta) || return
    # Append the selection to the current command buffer.
    eval 'LBUFFER="$LBUFFER$selected_path"'
    # Redraw the prompt since Selecta has drawn several new lines of text.
    zle reset-prompt
}
# Create the zle widget
zle -N insert-selecta-path-in-command-line
# Bind the key to the newly created widget
bindkey "^S" "insert-selecta-path-in-command-line"

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
