#!/bin/bash

if [[ -z "${DOTPATH}" ]]; then
    echo "please set the env DOTPATH={path/to/dotfiles} before running this command"
    exit
fi

if [ $# -eq 0 ]; then
    echo "please provide the directory to configure..."
    exit
fi

if [ ! -d "$1" ]; then
    echo "directory does not exist"
    exit
fi

# Check if the directory set has configs inside of .config
if [ -d "$1/.config/$1" ]; then
    echo "directory is a .config directory"
    ln -sf "${DOTPATH}$1/.config/$1" "${HOME}/.config/"
fi

echo "finished"
