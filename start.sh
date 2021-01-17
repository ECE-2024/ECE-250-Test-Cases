#!/bin/bash

help(){
	echo
	echo "FORMATTING:"
	echo "./setup.sh <WATID> <SERVER NUMBER (1 or 2)> <DIRECTORY NAME>"
	echo "DIRECTORY NAME IS WHERE YOUR FILES WILL BE COPIED TO ON THE ECE SERVERS. THE PATH WILL BE:"	
	echo "/home/<WATID>/projects/<DIRECTORY NAME>"
	echo "EXITING..."
	echo
	exit -1	
}

if [ -z "$1" ]
	then
		echo "NO WATID SPECIFIED (ie. k5kumara)."
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

if [ -z "$3" ]
	then
		echo "NO DIRECTORY NAME SPECIFIED (ie. "ECE250-p1")."
		help
	else
		PROJ_DIR=$3
fi

ssh $WATID@eceubuntu$SERVER_NUM.uwaterloo.ca  "mkdir /home/$WATID/projects;mkdir /home/$WATID/projects/$PROJ_DIR;exit"
scp -r ../$PROJ_DIR $WATID@eceubuntu1.uwaterloo.ca:/home/$WATID/projects

echo "PROJECT COPIED TO:"
echo "/home/$WATID/projects/$PROJ_DIR"

ssh $WATID@eceubuntu$SERVER_NUM.uwaterloo.ca  "g++ /home/$WATID/projects/$PROJ_DIR/*.cpp -o a.out;echo 'running program...';./a.out"


