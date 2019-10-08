# remember pwd fo the first time this is loaded
export TOP="${TOP:-$(pwd)}"
echo TOP=$TOP

SCRIPTS=$(cd $TOP/../scripts; pwd)

function show-diffs() {
    echo '---------- FILES <-> INDEX'
    git diff "$@"
    echo '---------- INDEX <-> HEAD'
    git diff --cached
}

# this is for notebooks hosted on nbhosting
case "$TERM" in
    dumb)
        export TERM=xterm ;;
    *)
        ;;
esac

# in case the git alias has been wiped out
# because the container was upgraded or any other reason

git config alias.l > /dev/null || git config --global alias.l "log --oneline --graph"
