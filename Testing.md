# Testing C++ Programs on Linux Distros

## Preface
This document will tell you how to easily test your C++ code using the provided .in and .out files, and how to memory profile your C++ programs to see if there are memory leaks, invalid access, and further issues.

**This document will focus on testing on ECE Ubuntu ONLY! This will NOT focus on local testing on Windows, Mac, etc. Regardless, you should be testing on ECE Ubuntu anyways!** 

## Setup
Before we can continue with this tutorial, we need to set up our files on ECEUbuntu so that we can use them directly on the server! If you have WSL installed on your system or your own linux-distro server, the commands later in the tutorial will work there as well.

To access our files and to run our commands, we will need to SSH into ECE Ubuntu

**SSH into ECE Ubuntu**
To initiate an SSH connection, you must first be logged into the waterloo VPN

After you've confirmed you're logged into the VPN, you can open your native Command Prompt, Terminal, etc, and type the followign command;

`ssh {WATID}@eceubuntu{the server number you want to use, 1 or 2}.uwaterloo.ca`

e.g;

`ssh k5kumara@eceubuntu1.uwaterloo.ca`

After running this command, you'll be prompted with a message that says;

```
The authenticity of host 'eceubuntu1.uwaterloo.ca (129.97.56.12)' can't be established.
ECDSA key fingerprint is SHA256:u0RB5xhytXu1QLWptM+p9UeZXTQZ7AawIC0hbMGZPYM.
Are you sure you want to continue connecting (yes/no)?
```

To this prompt, type "yes".

Afterwards, you will be asked to enter your password, this should be your WatIAM(LEARN) password. It might also prompt you for 2FA information, which will be pretty straightforward from there.

After entering your information in successfully, you will have access to the ECE Ubuntu terminal.

**Uploading files manually to ECE Ubuntu**
Sometimes (especially if you haven't used the VS tutorial Dre published), you will need to upload your files manually into ECE Ubuntu. Again, to do this, you must be connected to the waterloo VPN.

To do this, we will use a program called FileZilla, you can download it at https://filezilla-project.org/download.php?platform=win64

After downloading and installing the program, open it and click `File -> Site Manager`. It should open up an interface as follows;

![enter image description here](https://i.imgur.com/CkS1rWg.png)

In this interface, we will click `New Site`, and it should open up a blank section for you;

![enter image description here](https://i.imgur.com/LdzGGc7.png)

In the `Host` field, enter `eceubuntu{the server number you want to use, 1 or 2}.uwaterloo.ca`. For example, `eceubuntu1.uwaterloo.ca`

Change the `Protocol` drop down option to be `SFTP`

For the `User`, type in your WatID. For example, `k5kumara`

For the `Password`, type in your WatIAM(Learn) password.

It should look similar to this;

![enter image description here](https://i.imgur.com/d4sUbD1.png)

Afterwards, click `Connect`

After connecting, you will be presented with a screen that looks like the following;

![enter image description here](https://i.imgur.com/NMmBThA.png)

The red box on the left represents your LOCAL COMPUTER and the red box on the right represents the REMOTE COMPUTER (which in this case is ECE Ubuntu!).

You can navigate the folder structure just the same as you would when using File Explorer on windows, and you can drag and drop files into the right side to upload them into that directory. That's it! It's that simple!

It would be a good idea to create a new folder on eceUbuntu called Projects, or something similar, and upload all of your project code there when you're ready to test (if you're not using the Visual Studio tutorial). It is imperative that if you want to test on eceubuntu, your final compiled C++ program is present on the server!

**If using Visual Studio**
If you're using Visual Studio, you should have already followed the tutorial we created to set up your remote environment. If you have not done so, please visit the instructions on the main page of this repository at https://github.com/ECE-2024/ECE-250-Test-Cases to view how to do so. The rest of this section assumes that you've used this tutorial. 

When using visual studio's remote setup, your files will be automatically uploaded and synced with ECE Ubuntu, or whatever server you chose to set up the remote environment on. You will not need to manually upload any of your files! Your files will be uploaded to the server to the directory `/home/{YOUR WATID}/projects/{YOUR VS PROJECT NAME}/.` You can find the compiled binaries (your final C++ program) at `/home/{YOUR WATID}/projects/{YOUR VS PROJECT NAME}/bin/x64/Debug`, your final C++ program will usually have the extension `.out`.

For example, my final C++ program is located at;

`/home/k5kumara/projects/ECE250P0/bin/x64/debug/ECE250P0.out`

**If using other IDES**
Other IDEs, for example, CLION, usually have a remote deployment functionality, search for how these functionalities work for your specific IDE and use the same connection information that we used in the FileZilla setup to set it up! It will make your life a lot easier and automatically deploy your files to ECE Ubuntu upon various different actions (that you specify)

Otherwise, you can use the FileZilla method to manually transfer your files over to ECE Ubuntu!

## Testing with .in and .out files
ECE 250 provides us with sets of .in and .out files, and you can also create your own testcases using this format. IN and OUT files are simple plaintext files that contain standard input lines that are passed into a program, and what the program should output for these lines.

If we break down this problem, all we really need to do is pipe the input file into our program, and compare it with what the output file looks like. We will use two important operators and a command to do this, keep these in mind for later so you know how the general command example near the end of this section actually WORKS and you aren't just copying it for the sake of it!

The `<` operator in most linux distros allows us to redirect the contents of a command or a file into another command. This redirection will mimic standard input! For example, if we had a compiled C++ program called `testprogram.out`, and we had an input file called `input.txt`, we can make the C++ program read our input file by running the program alongside the `<` operator; `./testprogram.out < input.txt`

Next, the `|` operator is called the pipe, it lets you use two or more commands such that output of one command serves as input to the next. For example, returning to our C++ program `testprogram.out`, lets assume that this program prints out a bunch of random letters and numbers. If we wanted to search the output of the program for a specific number, we can use the pipe operator; `./testprogram.out | grep 5`, this would search for the number 5 in the program's output! (Don't worry about grep, it's just used as an example here, grep just lets you search for things in a file or program output). In this example case, the output of ./testprogram.out is the input of the grep command, accomplished by the pipe operator! 

Finally, the `diff` command lets you view the difference between two files, or two outputs. For example, if we ran the command `diff test1.txt test2.txt`, it would show you the differences between the two text files.

To wrap it all together, we can build a command that we can use to test our C++ program using the provided input and output files;

`./{C++ OUTFILE LOCATION} < {TEST INPUT FILE} | diff {TEST OUTPUT FILE} -`

C++ OUTFILE LOCATION - The location of your compiled C++ program on the server

TEST INPUT FILE - The location of the test{x}.in file on the server

TEST OUTPUT FILE - The location of the test{x} out file on the server.

Example usage;
`./ECE250Project0.out < test01.in | diff test01.out -`

**If your program ran these test{x} successfully, it will show you **NOTHING** after running this command.** 

If your program had mismatches between the input and the output, the command will show you where the mismatches are! For example, just to test, if we ran the diff command between the test1.in and the test1.out files, which are obviously different from each other, it will show us something like this;
![enter image description here](https://i.imgur.com/5VGW3V3.png)

Where the top box is the first file, and the second box is the second file, and all the lines that show up are lines that did not match between the two! In the case of your program, the top box will be your program's output and the bottom box will be output specified in the outfile!

## Diagnosing Memory Leaks with ValGrind
To diagnose memory issues, we will be using a program called ValGrind. ECEUbuntu already has valgrind installed by default so we don't need to worry about installing new packages!

Checking for memory leaks is imperative because you risk losing a significant amount of marks in future project submissions if your code is found to have leaked memory.

If you are using your own server or WSL, I believe you can simply install valgrind by running the command `sudo apt-get install valgrind`.

Valgrind is a useful utility that tells us if we have memory leaks in our program or not.

To run it, we will use the following command;
`valgrind --leak-check=full ./{OUTFILE LOCATION} < {TEST FILE YOU WANT TO USE}`
e.g;
`valgrind --leak-check=full ./ECE250P0.out < test1.in`

Upon running this command, you will see some output that looks like this;
![enter image description here](https://i.imgur.com/b4fkIIv.png)
The first box will show you errors in the way that you perform operations in your C++ code. It may tell you that you're accessing uninitialized values, or you're trying to read invalid data! This is important as it may give you hints as to what's going wrong in your code!

The second section is the heap summary, it tells you how much memory was still allocated at the exit of the program (you want to have 0). If near the bottom it says `All heap blocks were freed -- no leaks are possible`, you have no memory leaks! Otherwise, it will show you exactly how much memory was leaked in the `in use at exit: X bytes in Y blocks` section. 

To view a more comprehensive set of instructions for valgrind, you can visit https://stackoverflow.com/questions/5134891/how-do-i-use-valgrind-to-find-memory-leaks.



