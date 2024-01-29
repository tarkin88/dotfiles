function ssh-bastion --wraps='ssh franksg88@34.105.19.155' --wraps='ssh franksg88@34.105.19.155 -o ServerAliveInterval=60 -o ServerAliveCountMax=10' --description 'alias ssh-bastion=ssh franksg88@34.105.19.155 -o ServerAliveInterval=60 -o ServerAliveCountMax=10'
  ssh franksg88@34.105.19.155 -o ServerAliveInterval=60 -o ServerAliveCountMax=10 $argv
        
end
