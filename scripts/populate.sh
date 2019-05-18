#!/bin/bash

function create-file() {
    local name=$1; shift
    local lines=$1; shift
    for line in $(seq $lines); do
        echo line$line of $name >> $name
    done
}

function create-two-files() {
    create-file file1 2
    create-file file2 3
}

function do-both-kinds-of-changes() {
    echo "δ2: une ligne dans l'index" >> README.md
    git add README.md
    echo "δ1: pas dans l'index" >> README.md
}

"$@"
