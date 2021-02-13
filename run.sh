#!/bin/bash

# Formatting information and examples
help() {
  echo
  echo "FORMATTING:"
  echo "./run.sh <WATID> [-s <SERVER NUMBER (1 OR 2)>] [-m <EXECUTABLE NAME (IF USING MAKEFILE)>] [-d (FOR DEBUGGING WITH GDB)]"
  echo "EXAMPLES:"
  echo "./run.sh j1smith"
  echo "./run.sh j1smith -s 2"
  echo "./run.sh j1smith -m maindriver"
  echo "./run.sh j1smith -d"
  echo "./run.sh j1smith -s 2 -m maindriver -d"
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
DIRECTORY="/home/$WATID/projects/${PWD##*/}/source"
BUILD_COMMAND="g++ -g -std=c++11 *.cpp -o a.out && echo 'SOURCE CODE COMPILED' || echo 'ERROR: COMPILATION FAILED'"
EXECUTABLE="a.out"
GDB_COMMAND=""

# Update variables with optional arguments
while getopts "s:m:d" opt; do
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
    # Executable Name
    m)
      BUILD_COMMAND="make && echo 'SOURCE CODE COMPILED' || echo 'ERROR: COMPILATION FAILED'"
      EXECUTABLE=${OPTARG}
      ;;
    # GDB Debugger
    d)
      GDB_COMMAND="gdb "
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
RUN_COMMAND="echo && echo 'PROGRAM STARTED' && $GDB_COMMAND./$EXECUTABLE && echo 'PROGRAM FINISHED'"
ssh -i ece_key $SERVER "
echo;
cd $DIRECTORY;
echo 'COMPILING SOURCE CODE...';
$BUILD_COMMAND;
test -e $EXECUTABLE && $RUN_COMMAND || echo && echo 'ERROR: EXECUTABLE $EXECUTABLE NOT FOUND';
exit;
"
