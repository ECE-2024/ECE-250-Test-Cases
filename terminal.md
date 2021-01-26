# Running C++ code remotely on ECE Ubuntu Servers through the terminal
This document covers how to run C++ code remotely on the ECE Ubuntu Servers

## Requirements
1. Connection to the UW VPN
2. A Bash terminal, such as Git Bash, Linux Terminal, or Mac Terminal

## One time setup
1. Download the start.sh, setup.sh, test.sh, test_make.sh, test_valgrind.sh, and test_valgrind_make.sh scripts from the ECE-2024/ECE-250-Test-Case repository
2. Copy the scripts to the same directory as your .cpp, .h, .in, and .out files
3. Open your terminal and navigate to the directory that you copied the scripts to
4. Run the command `./setup.sh YOUR_WATID SERVER_NUM` in your terminal, replacing the capital words with your own values, to generate and add ssh keys to the server. If permission to run setup.sh is denied, run the command 'chmod +x setup.sh' in your terminal
5. If asked if you are sure you want to connect to the server, enter y
6. When prompted for your password, enter your waterloo password
### Example usages
`./setup.sh j1smith 1`

## Running your code remotely
1. Run the command `./start.sh YOUR_WATID SERVER_NUM` in your terminal, replacing the capital words with your own values, to upload, compile, and run your code on the server. If permission to run start.sh is denied, run the command 'chmod +x start.sh' in your terminal
2. If you want to use your makefile to compile your code, run the command `./start.sh YOUR_WATID SERVER_NUM EXECUTABLE_NAME` in your terminal, with the EXECUTABLE_NAME being the name of the executable file generate
### Example usages
`./start.sh j1smith 1`
`./start.sh j1smith 1 mainfile`

## Testing your code with test cases
1. Run the command `./test.sh YOUR_WATID SERVER_NUM` in your terminal, replacing the capital words with your own values, to upload, compile, and test your code on the server. If permission to run start.sh is denied, run the command 'chmod +x test.sh' in your terminal
2. If you want to run a specific test, run the command `./test.sh YOUR_WATID SERVER_NUM TEST_NUM` in your terminal, with the TEST_NUM being the 2 digit test number for the test you want to run
### Makefile option
1. For the 2 commands above, you can replace `./test.sh`with `./test_make.sh` and specify the executable name after the server number to use your make file to compile
2. For the 3 commands above, you can replace `./test.sh` and `./test_make.sh` with `./test_val.sh` and `./test_val_make.sh` respectively to use valgrind when running tests
### Example usages
`./test.sh j1smith 1`
`./test.sh j1smith 1 03`
`./test_make.sh j1smith 1 mainfile`
`./test_make.sh j1smith 1 mainfile 03`
`./test_val.sh j1smith 1`
`./test_val.sh j1smith 1 03`
`./test_val_make.sh j1smith 1 mainfile`
`./test_val_make.sh j1smith 1 mainfile 03`
