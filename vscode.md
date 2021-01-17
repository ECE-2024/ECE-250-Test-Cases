# Running C++ code remotely on ECE Ubuntu Servers
This document covers how to run C++ code remotely on the ECE Ubuntu Servers

## Requirements
1. Connection to the UW VPN
2. A Bash terminal, such as Git Bash or Mac Terminal

## One time setup
1. Download the start.sh and setup.sh scripts from the ECE-2024/ECE-250-Test-Case repository
2. Move the start.sh and setup.sh scripts into the same directory as your .cpp and .h files
3. Run the command './setup.sh' in your terminal
4. If asked if you are sure you want to connect to the server, enter y
5. When prompted to log into the ece ubuntu server, enter your waterloo password

If permission to run setup.sh is denied, run the command 'chmod +x setup.sh' 

## Running your code remotely
1. Run the command './start.sh' in your terminal

If permission to run start.sh is denied, run the command 'chmod +x start.sh' 
