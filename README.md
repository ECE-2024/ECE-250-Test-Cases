# ECE 250 Test Case Repository
This respository is for storing test cases for projects in the ECE 250 course

# Contributing
To add test cases for a project, you will need to create a new branch and add your test cases to it. Once you have tested your test cases and are confident that they work, you will need to make a pull request to the main branch. After creating your pull request, you will need to get your pull request reviewed by another contributer. Once approved, your branch can be merged to main.

# Remote Linux Debugging on ECE Ubuntu Servers in Visual Studio for Windows
The following are steps to run your c++ code on the ECE Ubuntu servers for testing

## Install Visual Studio for Windows
Visit https://visualstudio.microsoft.com/downloads/ to download Visual Studio. You can select the Community version (free for everyone) or Enterprise version (free for students). The Professional version can also work, but is paid.

## Run the Visual Studio Installer
Run the Visual Studio Installer executable in administrative mode. If you have already run the executable, you can instead run the Visual Studio Installer program in administrative mode.

![alt text](https://cdn.discordapp.com/attachments/784836147280216078/799357645953433640/unknown.png)

## Choose the Version of Visual Studio
Select the version of Visual Studio of your choice

![alt text](https://cdn.discordapp.com/attachments/784836147280216078/799357986060632094/unknown.png)

## Select Workload and Install
You will need to add the 'Linux development with C++' workload to your version of Visual Studio. It is fine to have other workloads installed. You can leave the default optional downloads that are shown at the bottom of the installation details on the far right if you want.

![alt text](https://cdn.discordapp.com/attachments/784836147280216078/799495017542189107/unknown.png)

## Open Visual Studio
Open the version of Visual Studio you downloaded and click 'Create a new project'

![alt text](https://cdn.discordapp.com/attachments/784836147280216078/799491094089957386/unknown.png)

## Select C++ Console App for Linux

![alt text](https://cdn.discordapp.com/attachments/784836147280216078/799491407554412554/unknown.png)

## Create Project
![alt text](https://cdn.discordapp.com/attachments/784836147280216078/799491891140886528/unknown.png)

## Configure remote debugging
![alt text](https://cdn.discordapp.com/attachments/784836147280216078/799496978287427604/unknown.png)

## Connect to waterloo server
![alt text](https://cdn.discordapp.com/attachments/784836147280216078/799497403131625532/unknown.png)

Your code should now run remotely in debug mode on the ece ubuntu servers whenever you press the play button. All console input and output will go to the 'Linux Console Window' (button left or right). Try taking advantage of debugging features like setting break points, stepping over lines, moving back to a previous line, stepping into functions, etc.
