# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# RISHI'S BASHRC CONFIGURATIONS
# start Tmux by default at every shell startup
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux
fi

# starship prompt
export STARSHIP_CONFIG=~/.config/starship/starship.toml
eval "$(starship init bash)"

# PATH
export PATH='/home/rishi/.cargo/bin:'$PATH
export PATH='/home/rishi/.local/bin:'$PATH

# FZF
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

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
if [[ $- =~ i ]]; then
	bind '"\er": redraw-current-line'
	bind '"\C-g\C-f": "$(_gf)\e\C-e\er"' # bind ctrl-g ctrl-f for _gf()
	bind '"\C-g\C-b": "$(_gb)\e\C-e\er"' # bind ctrl-g ctrl-b for _gb()
	bind '"\C-g\C-h": "$(_gh)\e\C-e\er"' # bind ctrl-g ctrl-h for _gh()
fi
