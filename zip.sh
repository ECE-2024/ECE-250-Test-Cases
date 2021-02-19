#!/bin/bash

# Formatting information and examples
help(){
	echo
	echo "FORMATTING:"
	echo "./zip.sh <WATID> <PROJECT_NUMBER> [-s <SERVER NUMBER (1 OR 2)>]"	
	echo "EXAMPLES:"
	echo "./zip.sh j1smith 0"
	echo "./zip.sh j1smith 0 -s 2"
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

# Check if PROJECT_NUMBER is provided
if [ -z "$1" ]
	then
		echo "ERROR: NO PROJECT NUMBER SPECIFIED"
		help
	else
    PROJECT_NUMBER="_p$1"
    shift
fi

# Set variables
SERVER="$WATID@eceubuntu1.uwaterloo.ca"
DIRECTORY="/home/$WATID/projects/${PWD##*/}/source"
ARCHIVE_NAME="$WATID$PROJECT_NUMBER.tar.gz"

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

# Remove and create the $DIRECTORY folder on the server
ssh -i ece_key $SERVER "
echo;
echo 'CLEANING DIRECTORY $DIRECTORY...';
rm -rf $DIRECTORY;
mkdir -p $DIRECTORY;
echo 'DIRECTORY $DIRECTORY CLEANED';
exit;
"

# Copy .cpp, .h, Makefile, and .pdf files to the $DIRECTORY folder on the server
echo
echo "COPYING SOURCE CODE TO DIRECTORY $DIRECTORY..."
scp -i ece_key *.cpp *.h Makefile *.pdf $SERVER:$DIRECTORY
echo "SOURCE CODE COPIED TO DIRECTORY $DIRECTORY"

# Zip files
ssh -i ece_key $SERVER "
echo;
cd $DIRECTORY;
echo 'CREATING ARCHIVE FILE...';
tar -cvzf $ARCHIVE_NAME *;
echo 'ARCHIVE FILE CREATED';
exit;
"

# Copy archive file to the current directory
echo
echo "COPYING ARCHIVE FILE TO CURRENT DIRECTORY..."
rm -f $ARCHIVE_NAME
scp -i ece_key $SERVER:$DIRECTORY/$ARCHIVE_NAME $PWD
echo "ARCHIVE FILE COPIED TO CURRENT DIRECTORY"
