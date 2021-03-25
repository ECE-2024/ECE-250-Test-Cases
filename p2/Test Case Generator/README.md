# Test Case Generator for P2
This is a automatic test case generator for ECE 250 Project 2. The python file 
will automatically generate test cases and test your code. Please compile your 
project on ECEUbuntu

## READ BEFORE RUNNING

Note: This generator attempts to generate long test files in the hopes that it will cover 
all possible inputs. It might not test all possibilities and does not replace carefully made
test cases by real people.


## Running
To run this code first copy it to your project folder on ECEUbuntu and compile your project.

After, run
```bash
python3 TestCaseGenerator.py
```

The python file will test and generate test cases in a new folder called testcases and create
multiple different files.

test#.in - input of testcase  
test#.out - expected output of testcase  
test#.debug - a file with expected output and program input on the same line
\#.o - your program's output  
test#.failed - differences between your output and expected output

where # is the test case number.

The program will not delete the previous testcases. To run this generator again,
please run 

```bash
rm -r testcases
```

in your project directory to delete all previous testcases.

If there are any issues, please contact ryanz34#0442 on discord.