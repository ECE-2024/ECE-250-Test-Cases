#!/bin/bash

# Formatting information and examples
help(){
	echo
	echo "FORMATTING:"
	echo "./setup.sh <WATID> [-s <SERVER NUMBER (1 OR 2)>]"	
	echo "EXAMPLES:"
	echo "./setup.sh j1smith"
	echo "./setup.sh j1smith -s 2"
	echo
	exit -1	
}

# Check if WATID is provided
if [ -z "$1" ]
	then
		echo "ERROR: NO WATID SPECIFIED"
		help
	else
    WATID=$1
    shift
fi

# Set variables
SERVER="$WATID@eceubuntu1.uwaterloo.ca"

# Update variables with optional arguments
while getopts "s:" opt; do
  case "${opt}" in
    # Server Number
    s)
      if [ ${OPTARG} == "1" ] || [ ${OPTARG} == "2" ] 
        then
          SERVER="$WATID@eceubuntu${OPTARG}.uwaterloo.ca"
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
