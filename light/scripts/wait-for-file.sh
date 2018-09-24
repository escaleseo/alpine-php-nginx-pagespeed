while [ ! -f $1 ]
  do
    echo  "file '$1' don't exist, waiting 2 secs for it's creation";
    sleep 1;
  done
