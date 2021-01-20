# Remote Linux Debugging on ECE Ubuntu Servers in Visual Studio for Windows
The following are steps to run your c++ code on the ECE Ubuntu servers for testing.

## Requirements
You must be able to connect to the University of Waterloo VPN.

## Install Visual Studio for Windows
Visit https://visualstudio.microsoft.com/downloads/ to download Visual Studio. You can select the Community version (free for everyone) or Enterprise version (free for students). The Professional version can also work, but is paid.

![alt text](https://cdn.discordapp.com/attachments/784836147280216078/799682731624890398/unknown.png)

## Run the Visual Studio Installer Executable or Program
Run the Visual Studio Installer executable in administrative mode. If you have already run the executable before, you can instead run the Visual Studio Installer program in administrative mode.

![alt text](https://cdn.discordapp.com/attachments/784836147280216078/799357645953433640/unknown.png)

## Install or Modify your version of Visual Studio
If you do not already have the version of Visual Studio you want, click the 'Install' button next to the version of Visual Studio you want.
Else, click the 'Modify' button next to your version of Visual Studio. If you do not see the button, click the 'More' dropdown and it will be there.

![alt text](https://cdn.discordapp.com/attachments/784836147280216078/799676623170830397/unknown.png)

![alt text](https://cdn.discordapp.com/attachments/784836147280216078/799357986060632094/unknown.png)

## Select Workload
You will need to add the 'Linux development with C++' workload to your version of Visual Studio. It is fine to have other workloads installed. It is also fine to leave the default optional downloads that are shown at the bottom of the installation details column if you want. When ready, click the 'Install' or 'Modify' button.

![alt text](https://cdn.discordapp.com/attachments/784836147280216078/799495017542189107/unknown.png)

## Open Visual Studio
Once your installation is complete, open the version of Visual Studio you downloaded/modified and click 'Create a new project'.

![alt text](https://cdn.discordapp.com/attachments/784836147280216078/799491094089957386/unknown.png)

## Select C++ Console App for Linux
On the 'All languages' dropdown, select 'C++', and on the 'All platforms' dropdown, select 'Linux'. You can select either the 'Console Application', 'Empty Project', or 'Makefile Project'. Most likely you will want to choose 'Console Application'.

![alt text](https://cdn.discordapp.com/attachments/784836147280216078/799491407554412554/unknown.png)

## Create Project
Give your project and solution a name, and specify the location you want to keep the project and solution files. It is fine to place solution and project in the same directory if you want. When ready, click the create button.

![alt text](https://cdn.discordapp.com/attachments/784836147280216078/799491891140886528/unknown.png)

## Configure remote debugging
Once the project is open, click on the play button at the top of your screen. This will cause a window to pop up asking you to connect to a Linux server

![alt text](https://cdn.discordapp.com/attachments/784836147280216078/799496978287427604/unknown.png)

## Connect to the VPN
Connect to the Waterloo VPN if you are not already connected.

![alt text](https://cdn.discordapp.com/attachments/784836147280216078/799681906786435112/unknown.png)

## Connect to waterloo server
Enter the required information to connect to the server. The 'Host name' can either be 'eceubuntu1.uwaterloo.ca' or 'eceubuntu2.uwaterloo.ca'. The 'Port' is '22'. The 'User name' is your wat id (example: d22baker). The 'Authentication type' is 'Password'. The 'Password' is your university password. When ready, click 'Connect'

![alt text](https://cdn.discordapp.com/attachments/784836147280216078/799497403131625532/unknown.png)

Your code should now run remotely in debug mode on a ece ubuntu server whenever you press the play button. All console input and output will go to the 'Linux Console Window' (Can be viewed by going to the Debug > Linux Console). Try taking advantage of debugging features like setting break points, stepping over lines, moving back to a previous line, stepping into functions, etc.

## Troubleshooting
If Visual Studio has put red squiggly lines under the `#include ...` directive, put `using namespace std;` at the top of your file
### Example
`
using namespace std;
#include <iostream>

int main() {
  return 0;
}
`
