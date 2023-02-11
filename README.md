# DomesdayDuplicator-WinBuild

Note: Outdated.  Will be updated later.

1) Download qt (https://www.qt.io/download)  
1b) Click "Go open source" at the bottom right  
1c) Scroll down and click "Download the qt online installer" underneath "Looking for QT binaries"  
1d) Make sure it detects your OS as Windows, scroll down, and hit Download  

2) Run the installer, and sign in.  Hint: If you don't have an account, check bugmenot.  Change the installation options to "Default desktop installation (mingw + qt)".  Accept all other defaults.

Everything after Step 2 (but not including step 2) has been automated.  Follow Steps 1-2, and then run the following command.  Always make sure you trust scripts that you're running from the internet!  The script being pulled is available in this repo for your inspection.

```
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/TokugawaHeavyIndustries/DomesdayDuplicator-WinBuild/main/installscript-dd.ps1'))
```

Or, continue reading to do everything yourself.

3) Download libusb (https://github.com/libusb/libusb/releases/download/v1.0.23/libusb-1.0.23.7z) and extract it.

4) Create the folder C:\libusb.  This is where we'll be placing the libusb dependencies.  Inside the *extracted* libusb folder, copy all files from \MinGW64\dll and \include\libusb-1.0 to C:\libusb.  You should have three files inside C:\libusb at this point:
```
libusb.h
libusb-1.0.dll
libusb-1.0.dll.a
```

Note: from here on out, you must be in an Administrative shell.

5) Install chocolatey (https://chocolatey.org/install)

6) Install make and git:
```
choco install make
choco install git
```

7) Open up the MinGW QT shell as administrator (hint, type mingw into the start search)

8) Create a new folder, clone the repo into it, and navigate to the app:

```
mkdir C:\github
cd C:\github
git clone https://github.com/simoninns/DomesdayDuplicator.git
cd DomesdayDuplicator\Linux-Application\DomesdayDuplicator
```

9) Then compile and install:

```
qmake
make all
make install
windeployqt %cd%\release
```

The app will then be built in the release subfolder:

```
C:\github\DomesdayDuplicator\Linux-Application\DomesdayDuplicator\release
```
