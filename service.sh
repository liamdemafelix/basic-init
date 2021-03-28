#!/bin/bash

# Service signature
SIGNATURE="yourServiceName"

# Determine the action
ACTION=$1
if [ -z $ACTION ]
then
	echo "Invalid argument for action. Accepted: start | stop | restart | status"
fi

# Process lock checker
check_existing () {
  ACTIVE_SESSIONS=`/usr/bin/screen -list | grep ${SIGNATURE}`
  if [ -z "$ACTIVE_SESSIONS" ]
  then
    # No session found
    return 1
  fi
  # Session found
  return 0
}

# Start
do_start () {
  check_existing
  if [ $? -eq 0 ]
  then
    echo "An existing instance of ${SIGNATURE} was found."
    exit 1
  fi
  echo -n "Starting ${SIGNATURE}..."
  # Start: Run your app here
  # Example: /usr/bin/screen -S "${SIGNATURE}" -fa -d -m /home/ldemafel/apps/Radarr/Radarr -nobrowser
  echo " OK!"
  return 0
}

# Stop
do_stop () {
  check_existing
  if [ $? -eq 1 ]
  then
    echo "No active process for ${SIGNATURE} found."
    exit 1
  fi
  echo -n "Stopping ${SIGNATURE}..."
  ACTIVE=`/usr/bin/screen -list | grep ${SIGNATURE} | awk '{print $1}'`
  /usr/bin/screen -X -S "${ACTIVE}" quit
  echo " OK!"
  return 0
}

# Start
if [ "$ACTION" = "start" ]
then
  do_start
  exit $?
fi

# Stop
if [ "$ACTION" = "stop" ]
then
  do_stop
  exit $?
fi

# Restart
if [ "$ACTION" = "restart" ]
then
  do_stop
  do_start
  exit $?
fi

# Status
if [ "$ACTION" = "status" ]
then
  check_existing
  if [ $? -eq 0 ]
  then
    echo "${SIGNATURE} is running"
  else
    echo "${SIGNATURE} is NOT running"
  fi
  exit 0
fi
