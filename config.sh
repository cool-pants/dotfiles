#!/bin/bash

check() {
    if which $1 &> /dev/null; then
        echo "" &> /dev/null
    else
        echo "$1 Not present, please ensure installed before running this script"
        exit
    fi
}

check stow

stow --target=$HOME $1

echo "finished"
