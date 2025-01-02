set -Ux _ZO_EXCLUDE_DIRS "/home/frank/.local/share/*"
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/frank/.local/share/google-cloud-sdk/path.fish.inc' ]
    . '/home/frank/.local/share/google-cloud-sdk/path.fish.inc'
end
zoxide init fish | source
