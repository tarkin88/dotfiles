function cl --wraps='git clean -df;git checkout .' --description 'alias cl=git clean -df;git checkout .'
  git clean -df;git checkout . $argv
        
end
