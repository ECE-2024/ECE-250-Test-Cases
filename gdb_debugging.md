# Debugging with GDB
When running your code in debug mode (using the -d option with the run.sh script), you will enter the GDB debugger command line interface. You can add breakpoints, step through code, evaluate variables, and more while in debug mode. Check out https://web.eecs.umich.edu/~sugih/pointers/gdbQS.html for a quickstart guide on how to use GDB. Here are a few helpful commands while in debug mode.

## Breakpoints
To add a breakpoint on the current line, use the command `break`.

To add a breakpoint at the beginning of a function or at a specific line, use the commands `break <FILE_NAME>:<FUNCTION_NAME>` or `break <FILE_NAME>:<LINE_NUMBER>` respectively. Examples: `break Source.cpp:main`, `break main`, `break 4`, `break Tester.cpp:5`.

To view the currently set breakpoints, use the command `info break`.

To clear all breakpoints in a specific function or at a line, use the commands `clear <FILE_NAME>:<LINE_NUMBER>` or `clear <FILE_NAME>:<LINE_NUMBER>` respectively. If you know the breakpoint number, you can use the command `delete <BREAKPOINT_NUMBER>`. Examples: `clear Source.cpp:main`, `clear 6`, `delete 2`.

To enable or disable breakpoints, use the commands `en <BREAKPOINT_NUMBER>` or `dis <BREAKPOINT_NUMBER>` respectively. Examples:  `en 2`,  `dis 2`.

To ignore a breakpoint until it has been crossed x times, use the command `ignore <BREAKPOINT_NUMBER> <x>`. Examples: `ignore 4 2`.

### Shortcuts
- You can replace `break` with `b`.
- You can ignore the file name and colon if you are currently stopped in the file where the line or function is located.

## Stepping through code
To step through your program, there must be at least 1 breakpoint set in order to start stepping. Note that when stopped at a line, the line will only be executed AFTER you leave the line.

To start running your program, use the command `run`. Your program will run until it hits a breakpoint. The breakpoint information will show when it is hit. Until a breakpoint is hit, you can enter input into the terminal as if it was the console for your program.

To view the section of code you're in, use the command `list`. Use the command again or press enter again to view the next section of code.

To see the name of the file, function, and the current line number you are on, use the command `where`.

To move to the next line, use the command `next`. You will see the line you moved to in your terminal. If you do not see anything, your program is most likely expeciting input or is still trying to execute the current line. Press enter again to repeat the next command.

To step into a function call on the current line, use the command `step`. Note that you may move to a different file.

To resume running the program normally until another breakpoint is hit, use the command `continue`.

### Shortcuts
- You can replace `run`, `list`, `next`, `step`, and `continue` with `r`, `l`, `n`, `s`, and `c` respectively.

## Examining and setting data
To view a variable on the call stack, use the command `call <VARIABLE_NAME>`. If the variable is an object, you can access the properties on the object. Examples: `call position`, `call car.license_number`, `call person.first_name`, `call node->get_next()->get_name()`.

To set the value of primitive variables (numbers, characters, booleans), use the command `call <VARIABLE_NAME> = <VALUE>`. Examples: `call position = 4`.

### Tips
- To set the value of a string, use the command `call <STRING_VARIABLE>.assign("<TEXT>")`. Examples: `call lastname.assign("Smith")`.
