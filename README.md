# DomesdayDuplicator-WinBuild

Note: build is x64 only

1) Download qt (https://www.qt.io/download)
1b) Click "Go open source" at the bottom right
1c) Scroll down and click "Download the qt online installer" underneath "Looking for QT binaries"
1d) Make sure it detects your OS as Windows, scroll down, and hit Download

2) Run the installer, and sign in.  Hint: bugmenot
2b) check ok on lisence
2c) next screen will have red words that say you don't have any lcienses, thats ok, click next
2d) disable sending
2e) click default desktop installation, leave path default
2f) hit next a few times and let it install

2) install chocolatey (https://chocolatey.org/install)

3) install make (choco install make) and git (choco install git)

4) Download libusb (https://github.com/libusb/libusb/releases/download/v1.0.23/libusb-1.0.23.7z) and extract it.

5) Create the folder C:\libusb.  Inside the extracted libusb folder, browse to \MinGW64\dll and copy all the files to C:\libusb.  Additionally, copy C:\Users\matt\Downloads\libusb-1.0.23\include\libusb-1.0\libusb.h to C:\libusb.

6) Open up qt mingw (hint, type mingw into the start search)

7) Create a new folder, clone the repo into it, and navigate to the app:

```
mkdir C:\github
cd C:\github
git clone https://github.com/simoninns/DomesdayDuplicator.git
cd cd DomesdayDuplicator\Linux-Application\DomesdayDuplicator
```

8) Then compile and install:

```
qmake
make all
make install
windeployqt %cd%\release
```
