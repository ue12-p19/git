# remember pwd fo the first time this is loaded
export TOPLEVEL="${TOPLEVEL:-$(pwd)}"
echo TOPLEVEL=$TOPLEVEL

function show-repo() { git log --oneline --graph "$@"; }


function show-diffs() {
    echo '---------- FILES <-> INDEX'
    git diff "$@"
    echo '---------- INDEX <-> HEAD'
    git diff --cached
}


