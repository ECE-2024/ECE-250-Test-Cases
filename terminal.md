# Running C++ code remotely on ECE Ubuntu Servers through the terminal
This document covers how to run C++ code remotely on the ECE Ubuntu Servers

## Requirements
1. Connection to the UW VPN
2. A Bash terminal, such as Git Bash, Linux Terminal, or Mac Terminal

## One time setup
1. Download the setup.sh, run.sh, test.sh, and zip.sh scripts from the ECE-2024/ECE-250-Test-Case repository
2. Copy the scripts to the same directory as your .cpp, .h, .in, and .out files
3. Open your terminal and navigate to the directory that you copied the scripts to
4. Run the command `./setup.sh YOUR_WATID SERVER_NUM` in your terminal, replacing the capital words with your own values, to generate and add ssh keys to the server. If permission to run setup.sh is denied, run the command 'chmod +x setup.sh' in your terminal
5. If asked if you are sure you want to connect to the server, enter y
6. When prompted for your password, enter your waterloo password
### Example usages
`./setup.sh j1smith`
`./setup.sh j1smith -s 2` (runs on ece ubuntu 2 instead of 1)

## Running your code remotely
Run the command `./run.sh <YOUR_WATID>` in your terminal to upload, compile, and run your code on the server. If permission to run run.sh is denied, run the command 'chmod +x run.sh' in your terminal
### Example usages
`./run.sh j1smith`

`./run.sh j1smith -s 2` (runs on ece ubuntu 2 instead of 1)

`./run.sh j1smith -m maindriver` (uses Makefile and runs the executable specified)

`./run.sh j1smith -s 2 -m maindriver`

## Testing your code with test cases
Run the command `./test.sh YOUR_WATID` in your terminal to upload, compile, and test your code on the server. If permission to run test.sh is denied, run the command 'chmod +x test.sh' in your terminal
### Example usages
`./test.sh j1smith`

`./test.sh j1smith -s 2` (runs on ece ubuntu 2 instead of 1)

`./test.sh j1smith -m maindriver` (uses the Makefile to generate an executable and runs the executable specified)

`./test.sh j1smith -t 03`  (runs the specified test number instead of all the test cases)

`./test.sh j1smith -v` (uses valgrind for memory leak detection)

`./test.sh j1smith -s 2 -m maindriver -t 03 -v`

## Zipping files to create archive file
Run the command `./zip.sh YOUR_WATID PROJECT_NUMBER` in your terminal to upload, zip, and download an archive that contains the .cpp, .h, Makefile, and .pdf files. The format of the archive file will be similar to "j1smith_p0.tar.gz", except with the watid and project number specified. If permission to run zip.sh is denied, run the command 'chmod +x zip.sh' in your terminal
### Example usages
`./zip.sh j1smith 0`
`./zip.sh j1smith 0 -s 2` (runs on ece ubuntu 2 instead of 1)
