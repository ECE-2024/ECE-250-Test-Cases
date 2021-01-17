#!/bin/bash
WATID=d22baker
SERVER_NUM=1
PROJ_DIR=TEST

ssh $WATID@eceubuntu$SERVER_NUM.uwaterloo.ca  "mkdir /home/$WATID/projects;mkdir /home/$WATID/projects/$PROJ_DIR;exit"
scp -r ../$PROJ_DIR $WATID@eceubuntu1.uwaterloo.ca:/home/$WATID/projects
ssh $WATID@eceubuntu$SERVER_NUM.uwaterloo.ca  "g++ /home/$WATID/projects/$PROJ_DIR/*.cpp -o a.out;echo 'running program...';./a.out"
