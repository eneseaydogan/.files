function kc
    set -l old_shell $SHELL
    set -gx SHELL fish
    eval (keychain --eval ssh,gpg id_ed25519 BF85E064D564922E)
    set -gx SHELL $old_shell
end

