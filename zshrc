# If you come from bash you might have to change your $PATH.
# export PATH="$(npm get prefix)/bin":~/.local/bin:$PATH
export PATH=~/.local/bin:$PATH

# Path to your oh-my-zsh installation.
case `uname` in
  Darwin)
    export ZSH=/Users/andre/.oh-my-zsh
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

alias gconf="git config user.name \"amalbuquerque\"; git config user.email \"andre.albuquerque@remote.com\""

alias kp='kubectl get pods | grep'
alias kd='kubectl describe'
alias kl='kubectl logs -f'
alias ke='kubectl exec -it bash'

alias work='termdown 25m'

alias pbcopy="xclip -sel clip-board"

alias cat='batcat'
alias fd='fdfind'

fpath=(~/.zsh/completion $fpath)

# from https://news.ycombinator.com/item?id=40128826
autoload -U compinit && compinit
{
  # Compile the completion dump to increase startup speed. Run in background.
  zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
  if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
    # if zcompdump file exists, and we don't have a compiled version or the
    # dump file is newer than the compiled file
    zcompile "$zcompdump"
  fi
} &!

# needs to be after source $ZSH/oh-my-zsh.sh
# Check https://github.com/sindresorhus/pure
fpath+=$HOME/.zsh/pure
autoload -U promptinit && promptinit
prompt pure

eval "$(zoxide init --cmd j zsh)"

# we need to export these, so we can access them
# on child processes
export UID
export GID

case `uname` in
  Darwin)
    # this export is a workaround, check https://github.com/asdf-vm/asdf/issues/1103
    export ASDF_DIR=/Users/andre/.asdf
    . /Users/andre/.asdf/asdf.sh
    . /Users/andre/.asdf/completions/asdf.bash

    export STANDING_DESK=60946793-CD62-1BB8-756B-A6AD31E2918D
  ;;
  Linux)
    . $HOME/.asdf/asdf.sh
    . $HOME/.asdf/completions/asdf.bash

    export STANDING_DESK=D6:D8:6C:DE:9C:74
  ;;
esac

alias ,hvi='nvim --headless --listen 192.168.68.86:6666'
alias ,cvi='neovide --server=andre-jupiter:6666'
alias ll='eza -lah --time-style=long-iso --sort=modified --reverse'
alias nv='nvim'
alias vim='nvim'
alias k9s='k9s -n default'
alias weather="curl wttr.in/Corroios"
alias v="fd --type f --hidden --exclude .git | fzf-tmux -p --reverse | xargs nvim"
alias sit="idasen-controller --mac-address $STANDING_DESK --move-to 695"
alias stand="idasen-controller --mac-address $STANDING_DESK --move-to 1146"
alias stretch="idasen-controller --mac-address $STANDING_DESK --move-to 1229"
# restart karabiner
alias rk="sudo pkill Karabiner-DriverKit-VirtualHIDDeviceClient"
alias mf="git ls-files --other --modified --exclude-standard | xargs mix format"
alias ,tiex="MIX_ENV=test iex -S mix"
alias ,iex="iex -S mix"


alias ,pfeorapi="remotectl portforward eor-api -e production -l -c -r devops -p 5777 -g eu"
alias ,pftiger="remotectl portforward tiger -lc -r devops -e production"
alias ,pfoban="remotectl portforward tiger-oban -lc -r devops -e production -p 5333 -g eu"

export ERL_AFLAGS="-kernel shell_history enabled"
export AWS_PROFILE=sts

export LC_ALL="en_US.UTF-8"

# use it like this:
# for file in $(\ls -G *.jpg); do image_resize_quality "$file" resized_pics; done
image_resize_quality() {
    convert $1 -resize 75%x75% -quality 75 $2/$1
}

# use it like this:
# for file in $(\ls -G *.jpg); do convert_image_to_pdf "$file"; done
convert_image_to_pdf() {
    convert $1 -quality 100 $1.pdf
}

# for file in $(\ls -G *.jpg); do smarter_convert_image_to_pdf "$file"; done
smarter_convert_image_to_pdf() {
    convert $1 -quality 70 -density 72 -background white -page a4 $1.pdf
}

resize_pdf_to_a4() {
    pdfjam --outfile $1.resized.pdf --paper a4paper $1
}

# 2024-04-23 11:29, commented out below stuff to improve start times
# remote stuff
# compdef remotectl
# compdef _remotectl remotectl
# source <(remotectl completion zsh)
export AWS_PROFILE=sts

# source /usr/share/doc/fzf/examples/key-bindings.zsh
# source /usr/share/doc/fzf/examples/completion.zsh

eval "$(direnv hook zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

[ -f ~/.env.local ] && source ~/.env.local

# allow copy-paste over SSH to work
xhost +si:localuser:andre &>/dev/null
