# If you come from bash you might have to change your $PATH.
export PATH=~/.local/bin:$PATH

# Path to your oh-my-zsh installation.
case `uname` in
  Darwin)
    export ZSH=/Users/aalbuq/.oh-my-zsh
  ;;
  Linux)
    export ZSH=/home/andre/.oh-my-zsh
  ;;
esac

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME=""

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

# Check https://github.com/mavam/dotfiles/commit/e05b3243b8ce136e790d014dd023c5b00cfba6c4
plugins=(git docker docker-compose globalias kubectl zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

export EDITOR='nvim'
bindkey -v

# 2017/04/24 10:40:06, AA: https://dougblack.io/words/zsh-vi-mode.html
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward
bindkey "^[b" backward-word
bindkey "^[f" forward-word

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
get_docker_names() {
    docker ps | awk '{print $NF}' | grep -v "NAMES"
}

alias dps='get_docker_names | xargs docker stats'
alias cleanup_docker_images='docker rm -v $(docker ps -a -q -f status=exited) && docker rmi $(docker images -q -f dangling=true)'
alias de='docker exec -i -t'

alias dc='docker-compose'
alias dcu='docker-compose up -d'
alias dcd='docker-compose down'
alias ddc='docker-compose -f docker-compose.dev.yml'
alias ddcu='docker-compose -f docker-compose.dev.yml up -d'
alias ddcd='docker-compose -f docker-compose.dev.yml down'

alias ff="find . | fzf | xargs echo -n | xclip -selection clipboard"

alias gl="git log -p"
alias gls="git log --stat"
alias gd="git diff"

alias gp="git pull origin \$(current_branch)"
alias gpu="git push origin \$(current_branch)"
alias gpuf="git push origin \$(current_branch) --force-with-lease"

alias gc="git commit -v"
alias gca="git commit --amend"

alias gs="git status"

alias gch="git checkout -b hotfix/"
alias gcf="git checkout -b feature/"
alias gcb="git checkout -b"
alias gco="git checkout"

alias gri="git rebase -i HEAD~"

alias gm="git merge --no-ff"

alias ga="git add"
alias gaa="git add -A"
alias grh="git reset HEAD"
alias grhh="git reset HEAD --hard"

alias gst="git stash"
alias gstp="git stash pop"
alias gstl="git stash list"

alias gconf="git config user.name \"andre.alb\"; git config user.email \"andre.albuquerque@onfido.com\""

alias lu="~/dotfiles/open_urls.sh"

alias k13='kubectl_1_13'
alias k7='kubectl_1_7'

alias kp='kubectl get pods | grep'
alias kd='kubectl describe'
alias kl='kubectl logs -f'
alias ke='kubectl exec -it bash'

alias work='termdown 25m'

alias pbcopy="xclip -sel clip"
alias pbpaste='xclip -selection clipboard -o'


fpath=(~/.zsh/completion $fpath)

autoload -Uz compinit && compinit -i

# needs to be after source $ZSH/oh-my-zsh.sh
# Check https://github.com/sindresorhus/pure
fpath+=$HOME/.zsh/pure
autoload -U promptinit && promptinit
prompt pure

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

test -s "$HOME/.kiex/scripts/kiex" && source "$HOME/.kiex/scripts/kiex"

case `uname` in
  Darwin)
    [[ -s $(brew --prefix)/etc/profile.d/autojump.sh  ]] && . $(brew --prefix)/etc/profile.d/autojump.sh
  ;;
  Linux)
    . /usr/share/autojump/autojump.sh
  ;;
esac

# we need to export these, so we can access them
# on child processes
export UID
export GID

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/andre/google-cloud-sdk/path.zsh.inc' ]; then source '/home/andre/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/andre/google-cloud-sdk/completion.zsh.inc' ]; then source '/home/andre/google-cloud-sdk/completion.zsh.inc'; fi

if [ -f '/home/andre/dotfiles/secrets.zsh' ]; then source '/home/andre/dotfiles/secrets.zsh'; fi

test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
test -d ~/.dotnet/tools && export PATH=~/.dotnet/tools:$PATH
test -d ~/.gem/ruby/2.5.0/bin && export PATH=~/.gem/ruby/2.5.0/bin:$PATH

test -e ~/.config/creds/nexus && source ~/.config/creds/nexus
alias nv='nvim'
alias vim='nvim'

. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

export ERL_AFLAGS="-kernel shell_history enabled"
