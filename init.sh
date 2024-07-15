check() {
    if which $1 &> /dev/null; then
        echo "" &> /dev/null
    else
        echo "$1 Not present, please ensure installed before running this script"
        exit
    fi
}

check_file() {
    if ls $1 &> /dev/null; then
        return 0
    else
        return 1
    fi
}


setup_ssh() {
    if check_file ~/.ssh/$1; then
        echo "SSH $1 File exists Continuing"
        echo "If key registered press enter to continue...."
        read < /dev/tty
    else
        ssh-keygen -t ed25519 -C "muban.sg@gmail.com" -f ~/.ssh/$1 -P ""
        ssh-add ~/.ssh/$1
        echo "SSH Key generated, please copy the ssh public key to setup github ssh. Once done press enter to continue...."
        read < /dev/tty
    fi

}

setup_dotfiles() {
    if check_file ~/personal/dotfiles; then
        echo "Dotfiles folder exists. Press enter to continue...."
        read < /dev/tty
    else
        echo "Cloning dotfiles...."
        mkdir ~/personal &> /dev/null
        git clone git@github.com:cool-pants/dotfiles.git ~/personal/dotfiles
    fi
}

stow_file() {
    echo "Stowing $1"
    cd $HOME/personal/dotfiles/
    stow --restow --target=$HOME $1
}

ensure_installed="
curl
ssh
git
tmux
alacritty
exa
nvim
stow
"

dotfiles_list="
alacritty
bash
zsh
tmux
neovim
git
"

for val in $ensure_installed; do
    check $val
done

case "$1" in
    all)
        setup_ssh "personal"
        setup_dotfiles

        for val in $dotfiles_list; do
            stow_file $val
        done
        ;;
    ssh)
        setup_ssh "personal"
        ;;
    pull)
        setup_dotfiles
        ;;
    *)
        echo "Invalid option!"
        ;;
esac

echo "Finished setup"
