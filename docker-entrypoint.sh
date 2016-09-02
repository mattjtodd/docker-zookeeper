#!/bin/bash

set -e

# check to see if the first argument is a parameter, add command
if [ "${1:0:1}" = '-' ] ; then
  set -- start-foreground $@
fi

# if request foreground mode
if [ "$1" == "start-foreground" ] ; then
  ensemble=false
  while [[ $1 ]]
  do
    case "$1" in
      -s | --server)
        echo "server.$2" >> conf/zoo.cfg
        shift 2
        ensemble=true
        ;;
      -id)
        echo $2 > data/myid
        shift 2
        ;;
      *)
        shift
        ;;
    esac
  done

  if $ensemble ; then
    echo "initLimit=5" >> conf/zoo.cfg
    echo "syncLimit=2" >> conf/zoo.cfg 
  fi

  set -- su-exec zookeeper bin/zkServer.sh start-foreground
fi

exec "$@"




