# remember pwd fo the first time this is loaded
export TOPLEVEL="${TOPLEVEL:-$(pwd)}"
echo TOPLEVEL=$TOPLEVEL

SCRIPTS=$(cd $TOPLEVEL/../scripts; pwd)

function show-repo() { git log --oneline --graph "$@"; }


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
