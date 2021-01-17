#!/bin/bash
WATID=YOUR_WAT_ID
SERVER_NUM=EITHER_1_OR_2

ssh-keygen
ssh-copy-id -i ~/.ssh/id_rsa.pub $WATID@eceubuntu$SERVER_NUM.uwaterloo.ca
