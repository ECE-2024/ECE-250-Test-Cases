#!/bin/bash

help(){
	echo
	echo "FORMATTING:"
	echo "./start.sh <WATID> <SERVER NUMBER (1 or 2)> <EXECUTABLE NAME (optional)>"
	echo "EXAMPLE:"
	echo "./start.sh j1smith 1"
	echo "EXAMPLE WITH MAKEFILE EXECUTABLE:"
	echo "./start.sh j1smith mainfile "
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

if [ -z "$3" ]
	then
		MAKE_CMD="
		echo 'CLEANING...'	
		rm a.out;
		echo 'COMPILING...';
		g++ -std=c++11 *.cpp -o a.out;
		echo 'RUNNING...';
		./a.out;
		"
	else
		MAKE_CMD="
		echo 'CLEANING...';
		rm $3;
		echo 'COMPILING...';
		make;
		echo 'RUNNING...';
		./$3;
		"
fi

PROJ_DIR=${PWD##*/}

ssh -i ece_key $WATID@eceubuntu$SERVER_NUM.uwaterloo.ca "
echo 'MAKING PROJECT FOLDER...';
mkdir /home/$WATID/projects;
mkdir /home/$WATID/projects/$PROJ_DIR;
exit;
"

destination=$WATID@eceubuntu$SERVER_NUM.uwaterloo.ca:/home/$WATID/projects/$PROJ_DIR
echo "COPYING FILES..."
scp -i ece_key *.cpp $destination
scp -i ece_key *.h $destination
scp -i ece_key *.hpp $destination
scp -i ece_key *.in $destination
scp -i ece_key *.out $destination
scp -i ece_key Makefile $destination
echo "FILES COPIED TO /home/$WATID/projects/$PROJ_DIR"

ssh -i ece_key $WATID@eceubuntu$SERVER_NUM.uwaterloo.ca "
cd /home/$WATID/projects/$PROJ_DIR;
$MAKE_CMD
exit;
"
