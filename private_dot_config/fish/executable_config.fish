if status is-interactive
  # lua ~/.config/z.lua --init fish | source
    # Commands to run in interactive sessions can go here
end
fish_ssh_agent
pyenv init - | source
direnv hook fish | source
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/opt/google-cloud-cli/path.fish.inc' ]; . '/opt/google-cloud-cli/path.fish.inc'; end
