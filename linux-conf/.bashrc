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
alias dict="dict -d gcide"
alias dict-ehin="dict -d fd-eng-hin"
alias ll="ls -lFA"

# fzf
# checkout `apt info fzf` -> checkout /usr/share/doc/fzf/README.Debian
source /usr/share/doc/fzf/examples/key-bindings.bash
source /usr/share/doc/fzf/examples/completion.bash
