#!/bin/bash

pid=`cat /var/run/callcenter.pid`
COMMAND="$1"

case $COMMAND in

start)
  if [ $pid != "0" ]
  then
    echo "Already started [PID:$pid]"
  else
    nohup ./callcenter.pl > /dev/null 2>&1 &
    sleep 1
    $0 status $2
  fi
;;

stop)
  if [ $pid != "0" ]
  then
    kill $pid
  fi
  sleep 1
  $0 status $2
;;

restart)
  $0 stop $2
  $0 start $2
;;

status)
  if [ $pid != "0" ]
  then
    echo "Started [PID:$pid]"
  else
    echo "Stopped"
  fi
;;

pid)
  echo $pid
;;

*)
  echo " * Usage: $0 {start|stop|restart|pid}"
;;

esac

