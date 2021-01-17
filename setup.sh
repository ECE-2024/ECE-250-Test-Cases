#!/bin/bash
WATID=YOUR_WAT_ID
SERVER_NUM=EITHER_1_OR_2

ssh-keygen -t rsa -N "" -f ece_key
ssh-copy-id -i ece_key.pub $WATID@eceubuntu$SERVER_NUM.uwaterloo.ca
