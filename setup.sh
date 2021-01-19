#!/bin/bash

help(){
	echo
	echo "FORMATTING:"
	echo "./setup.sh <WATID> <SERVER NUMBER (1 or 2)>"	
	echo "EXAMPLE:"
	echo "./setup.sh j1smith 1"
	echo "EXITING..."
	echo
	exit -1	
}

if [ -z "$1" ]
	then
		echo "NO WATID SPECIFIED (ie. j1smith)."
		help
	else
		WATID=$1
fi

if [ -z "$2" ]
	then
		echo "NO SERVER NUMBER SPECIFIED (ie. 1 or 2)."
		help
	else
		if [ "$2" == "1" ] || [ "$2" == "2" ]
			then
				SERVER_NUM=$2
			else
				echo SERVER NUMBER MUST BE 1 OR 2
				help
		fi
fi

ssh-keygen -t rsa -N "" -f ece_key
ssh-copy-id -i ece_key.pub $WATID@eceubuntu$SERVER_NUM.uwaterloo.ca

echo "SSH KEY GENERATED FOR eceubuntu$SERVER_NUM.uwaterloo.ca"

