#!/bin/sh


check() {
    command -v "$1" &> /dev/null
}

# Install stow if not present; else install
if ! check stow ; then
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Detect the package manager and install GNU Stow
        if [ -f /etc/debian_version ]; then
            # For Debian-based distributions
            sudo apt update
            sudo apt install -y stow
        elif [ -f /etc/redhat-release ]; then
            # For Red Hat-based distributions
            sudo yum install -y stow
        else
            echo "Unsupported Linux distribution."
            exit 1
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew install stow -y
    fi

    # Verify the Stow install
    if check stow; then
        echo "Stow succesfully installed"
    else
        echo "Stow failed to install"
    fi
fi

ALL_CONFIGS="alacritty
zsh
git
nvim
tmux"


case "$1" in
    all)
        for value in $ALL_CONFIGS; do
            echo "stowing $value ..."
            stow --target=$HOME $value
        done
        ;;
    *)
        stow --target=$HOME $1
        ;;
esac

echo "finished"
