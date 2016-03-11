function hg_branch
    hg branch ^/dev/null
end

function hg_status
    if hg root >/dev/null 2>&1
        # modified files
        if test -n (echo (hg status -m))
            set_color red
            printf '●'
            set_color normal
        end

        # added files
        if test -n (echo (hg status -a))
            set_color green
            printf '●'
            set_color normal
        end

        # removed files
        if test -n (echo (hg status -rd))
            set_color blue
            printf '●'
            set_color normal
        end

        # untracked files
        if test -n (echo (hg status -u))
            set_color purple
            printf '●'
            set_color normal
        end
    end
end

function hg_prompt
    if hg root >/dev/null 2>&1
        set_color normal
        printf ' ['
        set_color -o green
        printf '%s' (hg_branch)
        hg_status
        set_color normal
        printf ']'
    end
end
