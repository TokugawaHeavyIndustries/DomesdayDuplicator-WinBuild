# DomesdayDuplicator-WinBuild

Note: build supports x64 only

1) Download qt (https://www.qt.io/download)  
1b) Click "Go open source" at the bottom right  
1c) Scroll down and click "Download the qt online installer" underneath "Looking for QT binaries"  
1d) Make sure it detects your OS as Windows, scroll down, and hit Download  

2) Run the installer, and sign in.  Hint: If you don't have an account, check bugmenot.  Change the installation options to "Default desktop installation (minggw + qt)".  Accept all other defaults.

3) Install chocolatey (https://chocolatey.org/install)

4) install make and git:
```
choco install make
choco install git
```

5) Download libusb (https://github.com/libusb/libusb/releases/download/v1.0.23/libusb-1.0.23.7z) and extract it.

6) Create the folder C:\libusb.  Inside the extracted libusb folder, browse to \MinGW64\dll and copy all the files to C:\libusb.  Additionally, copy C:\Users\matt\Downloads\libusb-1.0.23\include\libusb-1.0\libusb.h to C:\libusb.

7) Open up qt mingw (hint, type mingw into the start search)

8) Create a new folder, clone the repo into it, and navigate to the app:

```
mkdir C:\github
cd C:\github
git clone https://github.com/simoninns/DomesdayDuplicator.git
cd cd DomesdayDuplicator\Linux-Application\DomesdayDuplicator
```

9) Then compile and install:

```
qmake
make all
make install
windeployqt %cd%\release
```
