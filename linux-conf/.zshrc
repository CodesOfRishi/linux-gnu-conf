# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/rishi/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="robbyrussell"
ZSH_THEME="kayid"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.  HIST_STAMPS="dd/mm/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git
    zsh-autosuggestions
	fzf
	ripgrep
	themes
	timer
	# vi-mode
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# A FEW CONFIGURATIONS FROM BASH

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# RISHI'S ZSH INTERACTIVE SHELL CONFIGURATIONS

# start Tmux by default at every shell startup
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux
fi

# You may want to put all your additions into a separate file like
# ~/.zsh_aliases, instead of adding them here directly.

if [[ -f ~/.zsh_aliases ]]; then
	. ~/.zsh_aliases
fi

# bind 'home' key & 'end' key
# To know what your terminal reads from a particular key(s)
# execuate cat command (without arguments) & press the key to check the result

bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_COMMAND="fd --hidden --exclude .git/ --exclude '.gitignore' --type f"
export FZF_DEFAULT_OPTS="--bind 'ctrl-r:reload($FZF_DEFAULT_COMMAND),ctrl-/:toggle-preview' --header 'Press CTRL-R to reload' --height 70% --reverse --border --margin=1 --color='hl+:1,hl:1'"

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--bind 'ctrl-r:reload($FZF_CTRL_T_COMMAND)' --header 'Press CTRL-R to reload' --height 100% --border --preview 'bat --style=numbers --color=always --line-range :500 {}'"

export FZF_ALT_C_COMMAND="fd --hidden --exclude .git/ --type d"
export FZF_ALT_C_OPTS="--bind 'ctrl-r:reload($FZF_ALT_C_COMMAND)' --header 'Press CTRL-R to reload' --height 70% --border --preview 'tree -aC {}'"

# Use ~~ as the trigger sequence instead of the default **
export FZF_COMPLETION_TRIGGER='~~'
export FZF_COMPLETION_OPTS="--bind 'ctrl-r:reload($FZF_CTRL_T_COMMAND)' --header 'Press CTRL-R to reload' --height 90% --border --preview 'bat --style=numbers --color=always --line-range :500 {}'"

# fzf git configurations
is_in_git_repo() { # supporting functions
  git rev-parse HEAD > /dev/null 2>&1
}

fzf-down() { # supporting functions
  fzf --min-height 20 --border --bind ctrl-/:toggle-preview "$@"
}

# browse git status & select files
_gf() {
  is_in_git_repo || return
  git -c color.status=always status --short |
  fzf-down --height 70% -m --ansi --nth 2..,.. \
    --preview '(git diff -- {-1} | diff-so-fancy | sed 1,3d;)' |
  cut -c4- | sed 's/.* -> //'
}

# browse & select branches
_gb() {
  is_in_git_repo || return
  git branch -a --color=always | grep -v '/HEAD\s' | sort |
  fzf-down --height 50% --ansi --multi --tac --preview-window right:70% \
  --preview 'git log --oneline --graph --date=relative --color=always --pretty="format:%C(black)%C(bold)%cd %C(auto)%h%d %s %C(cyan)%an%C(auto)" $(sed s/^..// <<< {} | cut -d" " -f1)' |
  sed 's/^..//' | cut -d' ' -f1 |
  sed 's#^remotes/##'
}

# browse & select commit hashes
_gh() {
  is_in_git_repo || return
  git log --date=relative --format="%C(black)%C(bold)%cd %C(auto)%h%d %C(white)%s %C(cyan)%an%C(auto)" --graph --color=always |
  fzf-down --height 80% --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
    --header 'Press CTRL-S to toggle sort' \
    --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show | diff-so-fancy' |
  grep -o "[a-f0-9]\{7,\}"
}

# key bindings for fzf git configurations
# bind ctrl-g ctrl-f for _gf()
# bind ctrl-g ctrl-b for _gb()
# bind ctrl-g ctrl-h for _gh()

join-lines() {
  local item
  while read item; do
    echo -n "${(q)item} "
  done
}

bind-git-helper() {
  local c
  for c in $@; do
    eval "fzf-g$c-widget() { local result=\$(_g$c | join-lines); zle reset-prompt; LBUFFER+=\$result }"
    eval "zle -N fzf-g$c-widget"
    eval "bindkey '^g^$c' fzf-g$c-widget"
  done
}
bind-git-helper f b t r h s
unset -f bind-git-helper
