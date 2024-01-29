function snapshots --wraps='snapper -c root list' --description 'alias snapshots=snapper -c root list'
  snapper -c root list $argv
        
end
