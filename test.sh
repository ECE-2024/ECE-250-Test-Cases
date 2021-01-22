#!/bin/bash

help(){
	echo
	echo "FORMATTING:"
	echo "./test.sh <WATID> <SERVER NUMBER (1 or 2)> <TEST NUMBER (optional, must be 2 digits)>"
	echo "YOUR CURRENT FOLDER NAME IS WHERE YOUR FILES WILL BE COPIED TO ON THE ECE SERVERS. THE PATH WILL BE:"	
	echo "/home/<WATID>/projects/<CURRENT_FOLDER_NAME>"
	echo "EXAMPLE:"
	echo "./test.sh j1smith 1"
	echo "EXAMPLE WITH TEST NUMBER:"
	echo "./test.sh j1smith 1 01"
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
		TEST_CMD=""
		for test in $(ls | grep "test.*.in" | tr -d .in)
			do
				TEST_CMD+="echo 'TEST: $test';"
				TEST_CMD+="./a.out < $test.in | diff $test.out -;"
				TEST_CMD+="echo;"
			done
	else
		TEST_CMD+="echo 'TEST: test$3';"
		TEST_CMD+="./a.out < test$3.in | diff test$3.out -;"
		TEST_CMD+="echo;"
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
echo 'CONVERTING *.in AND *.out FILES TO UNIX TYPE'
dos2unix *.in
dos2unix *.out
echo 'CONVERSION COMPLETE'
echo 'CLEANING...';
rm a.out;
echo 'COMPILING...';
g++ -std=c++11 *.cpp -o a.out;
echo 'TESTING...';
$TEST_CMD
exit;
"
