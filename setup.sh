#!/bin/bash
WATID=d22baker
SERVER_NUM=1

ssh-keygen
ssh-copy-id -i ~/.ssh/id_rsa.pub $WATID@eceubuntu$SERVER_NUM.uwaterloo.ca
