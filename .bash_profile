[[ -f ~/.bashrc ]] && source ~/.bashrc

if [[ "$(tty)" == "/dev/tty1" ]]; then
    [[ -f ~/.files/private-env ]] && source ~/.files/private-env
    [[ -f ~/.files/env ]] && source ~/.files/env
    exec mango
fi
