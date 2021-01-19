#!/bin/bash

help(){
	echo
	echo "FORMATTING:"
	echo "./start.sh <WATID> <SERVER NUMBER (1 or 2)>"
	echo "YOUR CURRENT FOLDER NAME IS WHERE YOUR FILES WILL BE COPIED TO ON THE ECE SERVERS. THE PATH WILL BE:"	
	echo "/home/<WATID>/projects/<CURRENT_FOLDER_NAME>"
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

PROJ_DIR=${PWD##*/}

ssh -i ece_key $WATID@eceubuntu$SERVER_NUM.uwaterloo.ca  "mkdir /home/$WATID/projects;mkdir /home/$WATID/projects/$PROJ_DIR;exit"
destination=$WATID@eceubuntu$SERVER_NUM.uwaterloo.ca:/home/$WATID/projects/$PROJ_DIR
scp -i ece_key *.cpp $destination
scp -i ece_key *.h $destination
scp -i ece_key *.hpp $destination
scp -i ece_key *.in $destination
scp -i ece_key *.out $destination
scp -i ece_key makefile $destination
echo "PROJECT COPIED TO:"
echo "/home/$WATID/projects/$PROJ_DIR"

ssh -i ece_key $WATID@eceubuntu$SERVER_NUM.uwaterloo.ca  "
cd /home/$WATID/projects/$PROJ_DIR/; g++ *.cpp -o a.out; echo 'running program...'; ./a.out; exit;"
