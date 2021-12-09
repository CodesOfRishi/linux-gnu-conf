# accept the suggestion as far as the cursor moves
# To know what your terminal reads from a particular key(s)
# execuate cat command (without arguments) & press the key to check the result
bindkey "^[[1;5C" forward-word  # bind ctrl-<right arrow>
bindkey "^[[1;5D" backward-kill-word  # bind ctrl-<left arrow>
