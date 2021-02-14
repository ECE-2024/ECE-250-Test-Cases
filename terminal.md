# Running C++ code remotely on ECE Ubuntu Servers through the terminal
This document covers how to run C++ code remotely on the ECE Ubuntu Servers via a terminal.

## Requirements
1. Connection to the UW VPN.
2. A Bash terminal, such as Git Bash, Linux Terminal, or Mac Terminal.

## One time setup
1. Download the setup.sh, run.sh, test.sh, and zip.sh scripts to your local machine from the ECE-2024/ECE-250-Test-Case repository.
2. Copy the scripts to the same directory on your local machine as your .cpp, .h, .in, .out, Makefile, and .pdf files.
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

`./run.sh j1smith -d` (runs in debug mode using the GDB debugger)

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
Run the command `./zip.sh <WATID> <PROJECT_NUMBER> [-s <SERVER NUMBER (1 OR 2)>]` in your terminal to upload, zip, and download an archive that contains the .cpp, .h, Makefile, and .pdf files. The format of the archive file will be similar to `j1smith_p0.tar.gz`, except with the watid and project number specified. If permission to run zip.sh is denied, run the command 'chmod +x zip.sh' in your terminal.
### Example usages
`./zip.sh j1smith 0`

`./zip.sh j1smith 0 -s 2` (runs on ece ubuntu 2 instead of 1)

# Debugging tips
When running your code in debug mode (using the -d option with the run.sh script), you will enter the GDB debugger command line interface. You can add breakpoints, step through code, evaluate variables, and more while in debug mode. Check out https://web.eecs.umich.edu/~sugih/pointers/gdbQS.html for a quickstart guide on how to use GDB. Here are a few helpful commands while in debug mode.

## Breakpoints
To add a breakpoint at the beginning of a function or at a specific line, use the commands `break <FILE_NAME>:<FUNCTION_NAME>` or `break <FILE_NAME>:<LINE_NUMBER>` respectively.

To view the currently set breakpoints, use the command `info break`.

To clear all breakpoints in a specific function or at a line, use the commands `clear <FILE_NAME>:<LINE_NUMBER>` or `clear <FILE_NAME>:<LINE_NUMBER>` respectively. If you know the breakpoint number, you can use the command `delete <BREAKPOINT_NUMBER>`. 

To enable or disable breakpoints, use the commands `en <BREAKPOINT_NUMBER>` or `dis <BREAKPOINT_NUMBER>` respectively.

To ignore a breakpoint until it has been crossed x times, use the command `ignore <BREAKPOINT_NUMBER> <x>`.

### Shortcuts
- You can replace `break` with `b`.
- You can ignore the file name and colon if you are currently stopped in the file where the line or function is located.

## Stepping through code
To step through your program, there must be at least 1 breakpoint set in order to start stepping. Note that when stopped at a line, the line will only be executed AFTER you leave the line.

To start running your program, use the command `run`. Your program will run until it hits a breakpoint. The breakpoint information will show when it is hit. Until a breakpoint is hit, you can enter input into the terminal as if it was the console for your program.

To move to the next line, use the command `next`. You will see the line you moved to in your terminal. If you do not see anything, your program is most likely expeciting input or is still trying to execute the current line.

To step into a function call on the current line, use the command `step`. Note that you may move to a different file.

To resume running the program normally until another breakpoint is hit, use the command `continue`.

### Shortcuts
- You can replace `run`, `next`, `step`, and `continue` with `r`, `n`, `s`, and `c` respectively.

## Examining and setting data
To view the value of a variable on the call stack, use the command `print <VARIABLE_NAME>`.

To set the value of a variable, use the command `set <VARIABLE_NAME>=<VALUE>`.

### Shortcuts
- You can replace `print` with `p`.