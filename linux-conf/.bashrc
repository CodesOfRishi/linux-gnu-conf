# rishi's configuration
# prompt
export GIT_PS1_SHOWDIRTYSTATE=1
export PS1='\[\e[1;34m\]\w\[\e[0m\] \[\e[1;33m\]$(__git_ps1 "(%s) ")\[\e[0m\]\[\e[1;31m\]✘\[\e[0m\] ' # working_dir (git_dir) ✘
export PS1='\[\e[1;34m\]\w\[\e[0m\] \[\e[1;33m\]$(__git_ps1 " :(%s) ")\[\e[0m\]\[\e[1;31m\]✘\[\e[0m\] ' # working_dir  :(git_dir) ✘
export PS1='\[\e[1;34m\]\w\[\e[0m\] \[\e[1;33m\]$(__git_ps1 " (%s) ")\[\e[0m\]\[\e[1;31m\]✘\[\e[0m\] ' # working_dir  (git_dir) ✘
export PS1='\[\e[1;32m\]\[\e[0m\] \[\e[1;34m\]\w\[\e[0m\] \[\e[1;33m\]$(__git_ps1 " :(%s) ")\[\e[0m\]\[\e[1;31m\]✘\[\e[0m\] ' #  working_dir  :(git_dir) ✘
export PS1='\[\e[1;32m\]\[\e[0m\] \[\e[1;34m\]\w\[\e[0m\] \[\e[1;33m\]$(__git_ps1 " :(%s) ")\[\e[0m\]\[\e[1;31m\]✘\[\e[0m\] ' #  working_dir  :(git_dir) ✘
export PS1='\[\e[1;32m\]\[\e[0m\] \[\e[1;34m\]\w\[\e[0m\] \[\e[1;33m\]$(__git_ps1 " :(%s) ")\[\e[0m\]\[\e[1;31m\]\[\e[0m\] ' #  working_dir  :(git_dir) 
export PS1='\[\e[1;32m\]\[\e[0m\] \[\e[1;34m\]\w\[\e[0m\] \[\e[1;33m\]$(__git_ps1 " :(%s) ")\[\e[0m\]\[\e[1;31m\]\[\e[0m\] ' #  working_dir  :(git_dir) 
export PS1='\[\e[0;35m\]┌──  [\[\e[0m\]\[\e[1;34m\]\w\[\e[0m\]\[\e[0;35m\]]\[\e[0m\] \[\e[1;33m\]$(__git_ps1 " :(%s) ")\[\e[0m\]\n\[\e[0;35m\]└─\[\e[0m\] ' # ┌──  working_dir  :(git_dir)\n└─
export PS1='\[\e[1;36m\]┌──  [\[\e[0m\]\[\e[1;34m\]\w\[\e[0m\]\[\e[1;36m\]]\[\e[0m\] \[\e[1;33m\]$(__git_ps1 " (%s) ")\[\e[0m\]\n\[\e[1;36m\]└─\[\e[0m\] ' # ┌──  working_dir  (git_dir)\n└─

# PATH
export PATH='/home/rishi/.cargo/bin:'$PATH

# aliases
alias mv="mv -v"
alias cp="cp -v"
alias rm="rm -I"
alias dict="dict -d gcide"
alias dict-ehin="dict -d fd-eng-hin"
alias ll="ls -lFA"

# fzf
# checkout `apt info fzf` -> checkout /usr/share/doc/fzf/README.Debian
source /usr/share/doc/fzf/examples/key-bindings.bash
source /usr/share/doc/fzf/examples/completion.bash

export FZF_DEFAULT_COMMAND="fd --hidden --type f"
export FZF_DEFAULT_OPTS="--bind 'ctrl-r:reload($FZF_DEFAULT_COMMAND)' --header 'Press CTRL-R to reload' --height 70% --reverse --border --margin=1 --color='hl+:2,hl:2'"

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--bind 'ctrl-r:reload($FZF_CTRL_T_COMMAND)' --header 'Press CTRL-R to reload' --height 100% --border --preview 'bat --style=numbers --color=always --line-range :500 {}'"

export FZF_ALT_C_COMMAND="fd --hidden --type d"
export FZF_ALT_C_OPTS="--bind 'ctrl-r:reload($FZF_ALT_C_COMMAND)' --header 'Press CTRL-R to reload' --height 70% --border --preview 'tree -aC {}'"

# Use ~~ as the trigger sequence instead of the default **
export FZF_COMPLETION_TRIGGER='~~'
export FZF_COMPLETION_OPTS="--bind 'ctrl-r:reload($FZF_CTRL_T_COMMAND)' --header 'Press CTRL-R to reload' --height 90% --border --preview 'bat --style=numbers --color=always --line-range :500 {}'"
