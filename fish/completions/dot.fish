# fish completion for dot — dotfiles manager

set -l commands deploy list add link rm backup open

# Top-level commands
complete -c dot -f -n "not __fish_seen_subcommand_from $commands" \
  -a "deploy list add link rm backup open" \
  -d "Dotfiles manager"

# add
complete -c dot -f -n "__fish_seen_subcommand_from add" \
  -l move -d "Move instead of copy"
complete -c dot -f -n "__fish_seen_subcommand_from add link" \
  -l home -d "Link to ~/ instead of ~/.config/"

# link — filesystem paths under ~/.files/
complete -c dot -f -n "__fish_seen_subcommand_from link" \
  -a "(__fish_complete_path ~/.files/)"

# rm
complete -c dot -f -n "__fish_seen_subcommand_from rm" \
  -l unlink -d "Remove symlink at target"
complete -c dot -f -n "__fish_seen_subcommand_from rm" \
  -l remove-files -d "Delete files from ~/.files"
complete -c dot -f -n "__fish_seen_subcommand_from rm" \
  -a "(dot _entries 2>/dev/null)" \
  -d "Managed entry"

# backup subcommands
set -l bk_commands list diff restore prune create create-all
complete -c dot -f -n "__fish_seen_subcommand_from backup; and not __fish_seen_subcommand_from $bk_commands" \
  -a "list diff restore prune create create-all" \
  -d "Backup action"

# backup <list|diff|restore|create> — entry names
complete -c dot -f -n "__fish_seen_subcommand_from backup; and __fish_seen_subcommand_from list diff restore create; and not __fish_seen_subcommand_from prune create-all" \
  -a "(dot _entries 2>/dev/null)" \
  -d "Managed entry"

# open — entry names
complete -c dot -f -n "__fish_seen_subcommand_from open" \
  -a "(dot _entries 2>/dev/null)" \
  -d "Managed entry"
