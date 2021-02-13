#!/bin/bash

# Formating information and examples
help() {
  echo
  echo "FORMATTING:"
  echo "./test.sh <WATID> [-s <SERVER NUMBER (1 OR 2)>] [-m <EXECUTABLE NAME (IF USING MAKEFILE)>] [-t <TEST NUMBER (01, 02, ...)>] [-v (FOR VALGRIND)]"
  echo "EXAMPLES:"
  echo "./test.sh jsmith"
  echo "./run.sh jsmith -s 2"
  echo "./run.sh jsmith -m maindriver"
  echo "./run.sh jsmith -t 01"
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
TEST_COMMAND=""
VALGRIND_COMMAND=""

# Update variables with optional arguments
while getopts "s:m:t:v" opt; do
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
			if [ TEST_COMMAND ]
				then
					TEST_COMMAND=${TEST_COMMAND//$EXECUTABLE/${OPTARG}}
			fi
			
			BUILD_COMMAND="make"
			EXECUTABLE=${OPTARG}
      ;;
		# Test Number
		t)
			TEST_COMMAND="
			echo
			echo 'TEST ${OPTARG} STARTED';
			$VALGRIND_COMMAND./$EXECUTABLE < test${OPTARG}.in | diff test${OPTARG}.out -;
			echo 'TEST ${OPTARG} FINISHED';
			"
			;;
		# Should use Valgrind
		v)
			VALGRIND_COMMAND="valgrind --leak-check=full "

			if [ TEST_COMMAND ]
				then
					TEST_COMMAND=${TEST_COMMAND//.\/$EXECUTABLE/$VALGRIND_COMMAND.\/$EXECUTABLE}
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

# If no specific test case is specified, run all test cases
if [ -z "$TEST_COMMAND" ]
	then
		for test in $(ls | grep "test.*.in" | tr -d .in)
			do
				TEST_COMMAND+="
				echo;
				echo 'TEST $test STARTED';
				$VALGRIND_COMMAND./$EXECUTABLE < $test.in | diff $test.out -;
				echo 'TEST $test FINISHED';
				"
			done
fi

# Remove and create the $DIRECTORY folder on the server
ssh -i ece_key $SERVER "
echo;
echo 'CLEANING DIRECTORY $DIRECTORY...';
rm -rf $DIRECTORY;
mkdir -p $DIRECTORY;
echo 'DIRECTORY $DIRECTORY CLEANED';
exit;
"

# Copy .cpp, .h, .in, .out, and Makefile files to the $DIRECTORY folder on the server
echo
echo "COPYING SOURCE CODE TO DIRECTORY $DIRECTORY..."
scp -i ece_key *.cpp *.h *.in *.out Makefile $SERVER:$DIRECTORY
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
$TEST_COMMAND
exit;
"
