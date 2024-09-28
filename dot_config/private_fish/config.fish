if status is-interactive
    # Commands to run in interactive sessions can go here
end
set fish_greeting
bind \cr _fzf_search_history
bind -M insert \cr _fzf_search_history
zoxide init fish | source
