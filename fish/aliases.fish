# basic
alias vi="lvim"
alias vim="lvim"
alias lg="lazygit"

# git aliases (also uses ~/.gitconfig)
alias g="git"
alias gco="git co"
alias gcod="git cod"
alias gfo="git fo"
alias gnb="git nb"
alias gnbx="git nbx"
alias gst="git st"

# amazon
alias nds="ninja-dev-sync"
alias bb="brazil-build"
alias bbb="brazil-build build"
alias b3="brazil-build build"
alias bbr="brazil-build release"
alias bbt="brazil-build test"
alias bbf="brazil-build format-fix"
alias bbl="brazil-build lint-fix"
alias bbu="brazil-build single-unit-test"
alias bbc="brazil-build clean"
alias bbcb="brazil-build clean ; brazil-build"
alias bbcr="brazil-build clean ; brazil-build release"
alias brc="brazil-recursive-cmd"
alias brc_all="brc \"brazil-build clean && brazil-build\" --all "
alias bws="brazil ws"
alias sam="brazil-build-tool-exec sam"

alias wat="watson"
alias wats="watson start"
alias watr="watson stop"
alias waps="wats ap-support"

alias sdkmanager="sdkmanager --sdk_root=/Library/Android"

# privacy pole conduit roles (alpha/beta in us-west-2, gamma/prod in us-east-1)
alias pp-alpha-credentials="ada cred update --account=513982291898 --provider=conduit --role=IibsAdminAccess-DO-NOT-DELETE"
alias pp-beta-credentials="ada cred update --account=292966146994 --provider=conduit --role=IibsAdminAccess-DO-NOT-DELETE"
alias pp-gamma-credentials="ada cred update --account=345605054930 --provider=conduit --role=IibsAdminAccess-DO-NOT-DELETE"
alias pp-prod-credentials="ada cred update --account=768783451950 --provider=conduit --role=IdentityOncallReadOnly"

# HPCS conduit roles (us-east-1)
alias hpcs-alpha-credentials="ada cred update --account=945261933260 --provider=conduit --role=IibsAdminAccess-DO-NOT-DELETE"
alias hpcs-beta-credentials="ada cred update --account=471937419820 --provider=conduit --role=IibsAdminAccess-DO-NOT-DELETE"
alias hpcs-gamma-credentials="ada cred update --account=272237724837 --provider=conduit --role=IibsAdminAccess-DO-NOT-DELETE"
alias hpcs-prod-credentials="ada cred update --account=186476458307 --provider=conduit --role=IibsAdminAccess-DO-NOT-DELETE"

function notify
    osascript -e 'display notification "😎" with title "Process Finished"'
    say -v Samantha "process finished"
end
