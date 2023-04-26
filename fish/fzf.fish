
# Setting ag as the default source for fzf
export FZF_DEFAULT_COMMAND='ag -g ""'

# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# function fzf_vim
#     vim (fzf)
# end

# some aliases

# traverse the current directory and open the selected file in vim
alias vf="fzf > $TMPDIR/fzf.result; and vim (cat $TMPDIR/fzf.result)"

