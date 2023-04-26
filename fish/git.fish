function _branch
    git branch 2> /dev/null | grep -e '\* ' | sed 's/^..\(.*\)/\1/'
end

function git_prompt
    set -l toplevel (command git rev-parse --show-toplevel)

    if test -n "$toplevel"
        set_color normal
        printf ' ['
        set_color -o green
        printf '%s' (git_branch)

        # modified files
        if test -n (echo (git status --porcelain | awk '{ print $1 }' | grep -E "M"))
            set_color red
            printf '●'
            set_color normal
        end

        # removed files
        if test -n (echo (git status --porcelain | awk '{ print $1 }' | grep -E "R"))
            set_color blue
            printf '●'
            set_color normal
        end

        # untracked files
        if test -n (echo (git status --porcelain | awk '{ print $1 }' | grep -E "\?"))
            set_color purple
            printf '●'
            set_color normal
        end

        set_color normal
        printf ']'
    end
end
