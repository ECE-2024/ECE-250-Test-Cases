#!/bin/bash

# Formating information and examples
help() {
  echo
  echo "FORMATTING:"
  echo "$0 <WATID> [-s <SERVER NUMBER (1 OR 2)>] [-m <EXECUTABLE NAME (IF USING MAKEFILE)>]"
  echo "EXAMPLES:"
  echo "./run.sh jsmith"
  echo "./run.sh jsmith -s 2"
  echo "./run.sh jsmith -m maindriver"
  echo "./run.sh jsmith -s 2 -m maindriver"
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
CURRENT_FOLDER=${PWD##*/}
DIRECTORY="/home/$WATID/projects/$CURRENT_FOLDER/run"
BUILD_COMMAND="g++ -std=c++11 *.cpp -o a.out"
EXECUTABLE="a.out"

# Update variables with optional arguments
while getopts "s:m:" opt; do
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
    # Executable Name
    m)
      BUILD_COMMAND="make"
      EXECUTABLE=${OPTARG}
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

# Remove and create the $DIRECTORY folder on the server
ssh -i ece_key $SERVER "
echo;
echo 'CLEANING DIRECTORY $DIRECTORY...';
rm -rf $DIRECTORY;
mkdir -p $DIRECTORY;
echo 'DIRECTORY $DIRECTORY CLEANED';
exit;
"

# Copy .cpp, .h, and Makefile files to the $DIRECTORY folder on the server
echo
echo "COPYING SOURCE CODE TO DIRECTORY $DIRECTORY..."
scp -i ece_key *.cpp *.h Makefile $SERVER:$DIRECTORY
echo "SOURCE CODE COPIED TO DIRECTORY $DIRECTORY"

# Convert files to unix line endings
ssh -i ece_key $SERVER "
echo;
cd $DIRECTORY;
echo 'CONVERTING FILES TO UNIX LINE ENDINGS...';
dos2unix -q *;
echo 'CONVERTED FILES TO UNIX LINE ENDINGS';
exit;
"

# Compile source code and run executable
ssh -i ece_key $SERVER "
echo;
cd $DIRECTORY;
echo 'COMPILING SOURCE CODE...';
$BUILD_COMMAND;
echo 'SOURCE CODE COMPILED';
echo;
echo 'PROGRAM STARTED';
./$EXECUTABLE;
echo 'PROGRAM FINISHED';
exit;
"
