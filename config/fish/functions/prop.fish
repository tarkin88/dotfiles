function prop --wraps=xprop --wraps=xprop\ \|\ awk\ \'/WM_CLASS/\ \{\ print\ \ \}\' --description alias\ prop=xprop\ \|\ awk\ \'/WM_CLASS/\ \{\ print\ \ \}\'
  xprop | awk '/WM_CLASS/ { print  }' $argv
        
end
