#!/bin/bash
WATID=YOUR_WATID
SERVER_NUM=EITHER_1_OR_2
PROJ_DIR=CURRENT_DIRECTOR_NAME

ssh $WATID@eceubuntu$SERVER_NUM.uwaterloo.ca  "mkdir /home/$WATID/projects;mkdir /home/$WATID/projects/$PROJ_DIR;exit"
scp -r ../$PROJ_DIR $WATID@eceubuntu1.uwaterloo.ca:/home/$WATID/projects
ssh $WATID@eceubuntu$SERVER_NUM.uwaterloo.ca  "g++ /home/$WATID/projects/$PROJ_DIR/*.cpp -o a.out;echo 'running program...';./a.out"
