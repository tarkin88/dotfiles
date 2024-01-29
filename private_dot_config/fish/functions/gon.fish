function gon --wraps='git checkout -b' --description 'alias gon=git checkout -b'
  git checkout -b $argv
        
end
