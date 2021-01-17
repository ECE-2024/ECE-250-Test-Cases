# Running C++ code remotely on ECE Ubuntu Servers
This document covers how to run C++ code remotely on the ECE Ubuntu Servers

## Requirements
1. Connection to the UW VPN
2. A Bash terminal, such as Git Bash, Linux Terminal, or Mac Terminal

## One time setup
1. Download the start.sh and setup.sh scripts from the ECE-2024/ECE-250-Test-Case repository
2. Copy the start.sh and setup.sh scripts to the same directory as your .cpp and .h files
3. Open the setup.sh file and set your watid and server number to the variables at the top
4. Open the start.sh file and set your watid, server number, and project directory to the variables at the top
5. Run the command './setup.sh' in your terminal
6. If asked if you are sure you want to connect to the server, enter y
7. When prompted for your password, enter your waterloo password

If permission to run setup.sh is denied, run the command 'chmod +x setup.sh' in your terminal

## Running your code remotely
1. Run the command './start.sh' in your terminal to upload, compile, and run your code on the server

If permission to run start.sh is denied, run the command 'chmod +x start.sh' in your terminal
