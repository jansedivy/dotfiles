$env.config.show_banner = false

$env.config.buffer_editor = 'nvim'

$env.config.history.file_format = 'sqlite'
$env.config.history.isolation = true

$env.config.highlight_resolved_externals = true
$env.config.color_config.shape_external_resolved = 'green'
$env.config.color_config.shape_internalcall = 'green'
$env.config.color_config.shape_external = 'red_bold'
$env.config.color_config.shape_externalarg = 'white'

# export PATH="/Users/jansedivy/.nodenv/shims:${PATH}"
$env.PATH = $env.PATH? | prepend '~/.nodenv/shims'

if ('/opt/homebrew' | path type) == 'dir' {
  $env.HOMEBREW_PREFIX = '/opt/homebrew'
  $env.HOMEBREW_CELLAR = '/opt/homebrew/Cellar'
  $env.HOMEBREW_REPOSITORY = '/opt/homebrew'
  $env.PATH = $env.PATH? | prepend [
    '/opt/homebrew/bin'
    '/opt/homebrew/sbin'
  ]
  $env.MANPATH = $env.MANPATH? | prepend '/opt/homebrew/share/man'
  $env.INFOPATH = $env.INFOPATH? | prepend '/opt/homebrew/share/info'
}

$env.PATH = $env.PATH? | append '~/.local/bin'
$env.PATH = $env.PATH? | append '~/.bun/bin'


$env.NO_HISTORY = ["fg", "gap"]

alias d = cd ~/Documents/scratch/

alias fg = job unfreeze

alias vi = nvim

alias dt = cd ~/.dotfiles

alias u = cd ..
alias uu = cd ../..

alias gap = git add --all -p
alias gp = git push --no-verify
alias gpf = git push --no-verify --force-with-lease
alias amend = git commit --amend --verbose --no-verify

alias rd = npm run dev
alias rb = npm run build

def --wrapped g [...rest] {
  if ($rest | is-empty) {
    git status
  } else {
    git ...$rest
  }
}

def fbr [] {
    let branches = (git branch --all
        | lines
        | str trim
        | where { |line| not ($line | str starts-with "*") }
        | each { |line| $line | str replace "remotes/origin/" "" }
        | uniq
    )

    if ($branches | is-empty) {
        error make { msg: "No branches found" }
    }

    let selected = ($branches | to text | fzf --height=40% --reverse | str trim)

    if ($selected | is-empty) {
        return
    }

    git checkout $selected
}

source prompt.nu
source ~/.zoxide.nu
