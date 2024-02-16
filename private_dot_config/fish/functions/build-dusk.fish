function build-dusk --wraps='git add config.def.h; rm config.h ; make; sudo make clean install; duskc run_command restart' --description 'alias build-dusk=git add config.def.h; rm config.h ; make; sudo make clean install; duskc run_command restart'
  git add config.def.h; rm config.h ; make; sudo make clean install; duskc run_command restart $argv
        
end
