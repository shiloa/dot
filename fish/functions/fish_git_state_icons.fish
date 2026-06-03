function fish_git_state_icons --description 'Render git status icons for the prompt'
    set -l porcelain (command git status --porcelain 2>/dev/null)
    or return
    test -n "$porcelain"; or return

    set -l has_new 0
    set -l has_modified 0
    set -l has_added 0
    set -l has_deleted 0

    for line in $porcelain
        if test $has_new -eq 0
            string match -qr '^\?\?' -- $line
            and set has_new 1
        end

        if test $has_modified -eq 0
            string match -qr '^M|^.M' -- $line
            and set has_modified 1
        end

        if test $has_added -eq 0
            string match -qr '^A' -- $line
            and set has_added 1
        end

        if test $has_deleted -eq 0
            string match -qr '^D|^.D' -- $line
            and set has_deleted 1
        end
    end

    if test $has_new -eq 0 -a $has_modified -eq 0 -a $has_added -eq 0 -a $has_deleted -eq 0
        return
    end

    printf ' '
    set -l printed 0

    if test $has_new -eq 1
        set_color yellow
        printf '?'
        set printed 1
    end

    if test $has_modified -eq 1
        test $printed -eq 1; and printf ' '
        set_color red
        printf 'M'
        set printed 1
    end

    if test $has_added -eq 1
        test $printed -eq 1; and printf ' '
        set_color green
        printf '+'
        set printed 1
    end

    if test $has_deleted -eq 1
        test $printed -eq 1; and printf ' '
        set_color red
        printf 'D'
    end
end
