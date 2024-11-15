if status is-interactive
    # Commands to run in interactive sessions can go here
end
set fish_greeting
bind \cr _fzf_search_history
bind -M insert \cr _fzf_search_history
zoxide init fish | source

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/frank/.local/share/google-cloud-sdk/path.fish.inc' ]; . '/home/frank/.local/share/google-cloud-sdk/path.fish.inc'; end
