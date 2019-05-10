#!/bin/bash

function create-files() {
    local from=$1; shift
    local until=$1; shift
    for file in $(seq $from $until); do
        for line in $(seq $((file + 2))); do
            echo line$line of file$file >> file$file
        done
#        git add file$file
#        git commit -m "création de file$file"
    done
}

function create-three-files() {
    create-files 1 3
}

function do-both-kinds-of-changes() {
    echo "δ2: une ligne dans l'index" >> README.md
    git add README.md
    echo "δ1: pas dans l'index" >> README.md
}

"$@"
