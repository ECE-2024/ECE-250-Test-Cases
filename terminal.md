# Running, Debugging, and Testing code remotely via terminal
This document covers how to run, debug, and test C++ code remotely on the ECE Ubuntu Servers via a terminal.

## Requirements
1. Connection to the UW VPN.
2. A Bash terminal, such as Git Bash, Linux Terminal, or Mac Terminal.

## One time setup
1. Download the setup.sh, run.sh, test.sh, and zip.sh scripts to your local machine from the [ECE-2024/ECE-250-Test-Case](https://github.com/ECE-2024/ECE-250-Test-Cases) repository.
2. Copy the scripts to the same directory as your .cpp, .h, .in, .out, Makefile, and .pdf files on your local machine.
3. Open your terminal and navigate to the directory that you copied the scripts to.
4. Run the command `./setup.sh <WATID> [-s <SERVER NUMBER (1 OR 2)>]` in your terminal to generate and add ssh keys to the server. If permission to run setup.sh is denied, run the command 'chmod +x setup.sh' in your terminal.
5. If asked if you are sure you want to connect to the server, enter y.
6. When prompted for your password, enter your waterloo password.
### Example usages
`./setup.sh j1smith`  
`./setup.sh j1smith -s 2` (runs on ece ubuntu 2 instead of 1)  

## Running your code remotely
Run the command `./run.sh <WATID> [-s <SERVER NUMBER (1 OR 2)>] [-m <EXECUTABLE NAME (IF USING MAKEFILE)>] [-d (FOR DEBUGGING WITH GDB)]` in your terminal to upload, compile, and run your code on the server. If permission to run run.sh is denied, run the command 'chmod +x run.sh' in your terminal.
### Example usages
`./run.sh j1smith`  
`./run.sh j1smith -s 2` (runs on ece ubuntu 2 instead of 1)  
`./run.sh j1smith -m maindriver` (uses the Makefile to generate an executable and runs the executable specified instead of a.out)  
`./run.sh j1smith -d` (runs in debug mode using the GDB debugger. Check out the [GDB Debugging Guide](https://github.com/ECE-2024/ECE-250-Test-Cases/edit/main/terminal.md) for more information)  
`./run.sh j1smith -s 2 -m maindriver -d`  

## Testing your code with test cases
Run the command `./test.sh <WATID> [-s <SERVER NUMBER (1 OR 2)>] [-m <EXECUTABLE NAME (IF USING MAKEFILE)>] [-t <TEST NUMBER (01, 02, ...)>] [-v (FOR VALGRIND)]` in your terminal to upload, compile, and test your code on the server. If permission to run test.sh is denied, run the command 'chmod +x test.sh' in your terminal.
### Example usages
`./test.sh j1smith`  
`./test.sh j1smith -s 2` (runs on ece ubuntu 2 instead of 1)  
`./test.sh j1smith -m maindriver` (uses the Makefile to generate an executable and runs the executable specified instead of a.out)  
`./test.sh j1smith -t 01`  (runs the specified test number instead of all the test cases)  
`./test.sh j1smith -v` (uses valgrind for memory leak detection)  
`./test.sh j1smith -s 2 -m maindriver -t 01 -v`  

## Zipping files to create archive file
Run the command `./zip.sh <WATID> <PROJECT_NUMBER> [-s <SERVER NUMBER (1 OR 2)>]` in your terminal to upload, zip, and download an archive that contains the .cpp, .h, Makefile, and .pdf files. The format of the archive file will be similar to `j1smith_p0.tar.gz`, except with the watid and project number specified. Please check that the archive file generated contains the correct files (you can unzip it with `tar -xf <ARCHIVE_FILE>`). If permission to run zip.sh is denied, run the command 'chmod +x zip.sh' in your terminal.
### Example usages
`./zip.sh j1smith 0`  
`./zip.sh j1smith 0 -s 2` (runs on ece ubuntu 2 instead of 1)  
