# rishi's configuration
# start Tmux by default at every shell startup
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux
fi

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

# starship prompt
eval "$(starship init bash)"

# PATH
export PATH='/home/rishi/.cargo/bin:'$PATH

# aliases
alias mv="mv -i"
alias rm="rm -I"
alias dict="dict -d gcide"
alias dict-ehin="dict -d fd-eng-hin"
alias ll="ls -lFA"

# fzf
# checkout `apt info fzf` -> checkout /usr/share/doc/fzf/README.Debian
source /usr/share/doc/fzf/examples/key-bindings.bash
source /usr/share/doc/fzf/examples/completion.bash

export FZF_DEFAULT_COMMAND="fd --hidden --type f"
export FZF_DEFAULT_OPTS="--bind 'ctrl-r:reload($FZF_DEFAULT_COMMAND)' --header 'Press CTRL-R to reload' --height 70% --reverse --border --margin=1 --color='hl+:1,hl:1'"

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--bind 'ctrl-r:reload($FZF_CTRL_T_COMMAND)' --header 'Press CTRL-R to reload' --height 100% --border --preview 'bat --style=numbers --color=always --line-range :500 {}'"

export FZF_ALT_C_COMMAND="fd --hidden --type d"
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
    --preview '(git diff --color=always -- {-1} | sed 1,4d;)' |
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
    --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always' |
  grep -o "[a-f0-9]\{7,\}"
}

# key bindings for fzf git configurations
if [[ $- =~ i ]]; then
	bind '"\er": redraw-current-line'
	bind '"\C-g\C-f": "$(_gf)\e\C-e\er"' # bind ctrl-g ctrl-f for _gf()
	bind '"\C-g\C-b": "$(_gb)\e\C-e\er"' # bind ctrl-g ctrl-b for _gb()
	bind '"\C-g\C-h": "$(_gh)\e\C-e\er"' # bind ctrl-g ctrl-h for _gh()
fi
