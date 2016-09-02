#!/bin/bash

set -e

# if request foreground mode
if [ "${1:0:1}" = '-' ] || [ "$1" == "start-foreground" ] ; then
  while [[ $1 ]]
  do
    case "$1" in
      -id)
        echo $2 > data/myid
        shift 2
        ;;
      -p | --property)
        echo $2 >> conf/zoo.cfg
        shift 2
        ;;
      *)
        shift
        ;;
    esac
  done

  set -- su-exec zookeeper bin/zkServer.sh start-foreground
fi

exec "$@"




