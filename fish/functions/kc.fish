function kc
    set -l old_shell $SHELL
    set -gx SHELL fish
    keychain --eval --quiet git 8067C36C4B94478F | source
    set -gx SHELL $old_shell
end

