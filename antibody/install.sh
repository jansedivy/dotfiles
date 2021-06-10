#!/bin/sh
brew install antibody
antibody bundle <"$ZSH/antibody/bundles.txt" >~/.zsh_plugins.sh
antibody update
