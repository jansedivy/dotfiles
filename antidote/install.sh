#!/bin/sh

brew install antidote

antidote bundle < "$ZSH/antidote/plugins.txt" > ~/.zsh_plugins.sh
