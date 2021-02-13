#!/bin/bash

# Formating information and examples
help(){
	echo
	echo "FORMATTING:"
	echo "./setup.sh <WATID> [-s <SERVER NUMBER (1 OR 2)>]"	
	echo "EXAMPLES:"
	echo "./setup.sh j1smith"
	echo "EXITING..."
	echo
	exit -1	
}

# Check if WATID is provided
if [ -z "$1" ]
	then
		echo "NO WATID SPECIFIED (ie. j1smith)."
		help
	else
    WATID=$1
    shift
fi

# Set variables
SERVER_NUM="1"
SERVER="$WATID@eceubuntu$SERVER_NUM.uwaterloo.ca"

# Update variables with optional arguments
while getopts "s:" opt; do
  case "${opt}" in
    # Server Number
    s)
      if [ ${OPTARG} == "1" ] || [ ${OPTARG} == "2" ] 
        then
          SERVER_NUM=${OPTARG}
          SERVER="$WATID@eceubuntu$SERVER_NUM.uwaterloo.ca"
        else
          echo "ERROR: INVALID SERVER NUMBER $OPTARG. MUST BE 1 OR 2"
          help
      fi
      ;;
    :)
      help
      ;;
    \?)
      help
      ;;
  esac
done 
shift $((OPTIND-1))

# Generate ssh key and upload the public key to the server
ssh-keygen -t rsa -N "" -f ece_key
ssh-copy-id -i ece_key.pub $SERVER

echo "SSH KEY GENERATED FOR $SERVER"
