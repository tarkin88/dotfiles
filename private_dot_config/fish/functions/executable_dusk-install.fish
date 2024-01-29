function dusk-install --wraps='rm config.h;make;sudo make clean install' --wraps='rm config.h;make;sudo make clean install; duskc run_command restart' --wraps='rm config.h;make;sudo make clean install;sleep 1s ; duskc run_command restart' --description 'alias dusk-install=rm config.h;make;sudo make clean install;sleep 1s ; duskc run_command restart'
  rm config.h;make;sudo make clean install;sleep 1s ; duskc run_command restart $argv
        
end
