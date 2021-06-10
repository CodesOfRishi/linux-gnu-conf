# rishi's configuration

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
