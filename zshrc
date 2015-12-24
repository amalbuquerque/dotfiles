# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

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
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH=$HOME/bin:/usr/local/bin:/usr/local/lib:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
export EDITOR='vim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set generic HTTP proxy for applications which honor http_proxy
# 2015/07/24 23:33:12, AA: PROXY_TO_USE set on .zshrc
# http_proxy=http://127.0.0.1:55342/
http_proxy=$PROXY_TO_USE
https_proxy=$http_proxy
ftp_proxy=$http_proxy
HTTP_PROXY=$http_proxy
HTTPS_PROXY=$http_proxy
FTP_PROXY=$http_proxy
export http_proxy HTTP_PROXY https_proxy HTTPS_PROXY ftp_proxy FTP_PROXY

# 2014-09-16, AA: para que consigamos utilizar o gvim
export DISPLAY="localhost:0"
# 2014-09-16, AA: para que apresente por defeito os caracteres UTF-8
export LC_ALL=pt_PT.UTF-8

# 2015/07/24, AA: From http://unix.stackexchange.com/a/41282/68722
# $- -> current options set for the shell (from http://stackoverflow.com/a/5163260/687420)
# *i* -> regex searching for an 'i', indicating it's an interactive shell; only in this case, run tmux
case $- in *i*)
  if [ -z "$TMUX" ]; then exec tmux; fi;;
esac

# 2015/10/14 22:22:43, AA: From
# https://www.reddit.com/r/vim/comments/3oowqn/stumbled_upon_a_nice_way_to_use_arrow_keys/
# To use vim keybindings on zsh
bindkey -v

# 2015/10/30 23:20:51, AA: From 
# http://stackoverflow.com/a/32398981/687420
export VAGRANT_DETECTED_OS=cygwin
