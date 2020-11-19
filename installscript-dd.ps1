$usbrel = "https://github.com/libusb/libusb/releases/download/v1.0.23/libusb-1.0.23.7z"
$chocodl = "https://chocolatey.org/install.ps1"
$7zip= "7Zip4PowerShell"

$rundatetime = Get-Date -Format yyyymmddhhmmss

# Query if 7z module is already installed, install if not

if (Get-Module -Name $7zip) {
    Write-Host "7zip already installed"
    }
else {
    Install-Module -Name $7zip -Force
    }

# Query if Chocolatey is installed, install if not

if (Test-Path "C:\ProgramData\chocolatey\choco.exe") {
    Write-Host "Chocolatey already installed"
    }
else {
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    }

# Install make and git

choco install make -y
choco install git -y

# Check if libusb already exists

if (Test-Path "C:\Libusb") {
    Write-Host "The folder C:\libusb exists.  Checking for correct libusb files."
    $libusbhok = Test-Path C:\libusb\libusb.h
    $libusbdllok = Test-Path C:\libusb\libusb-1.0.dll
    $libusbdllaok = Test-Path C:\libusb\libusb-1.0.dll.a
}
else {
    mkdir "C:\libusb"
    $libusbhok = $libusbdllok = $libusbddlaok = $FALSE
}

# Remediate libusb
if ($libusbhok -eq $false -or $libusbdllok -eq $false -or $libusbdllaok -eq $false) {
    mkdir C:\libusb\$rundatetime
    cd C:\libusb\$rundatetime
    Invoke-WebRequest $usbrel -OutFile "usbrel.7z"
    Expand-7Zip "usbrel.7z" -TargetPath ./

    if ($libusbhok -eq $False) {
        Copy-Item .\include\libusb-1.0\libusb.h C:\libusb
        $libusbhok = Test-Path C:\libusb\libusb.h
        if ($libusbhok -eq $FALSE){
            Write-Host "That wasn't supposed to happen."
            }
    }
    if ($libusbdllok -eq $False) {
        cp .\MinGW64\dll\libusb-1.0.dll C:\libusb
        $libusbhok = Test-Path C:\libusb\libusb-1.0.dll
        if ($libusbhok -eq $FALSE){
            Write-Host "That wasn't supposed to happen."
            }
    }
    if ($libusbdllaok -eq $False) {
        cp .\MinGW64\dll\libusb-1.0.dll.a C:\libusb
        $libusbhok = Test-Path C:\libusb\libusb-1.0.dll.a
        if ($libusbhok -eq $FALSE){
            Write-Host "That wasn't supposed to happen."
            }
    }

    cd C:\
    Remove-Item -Recurse -Force C:\libusb\$rundatetime

}

Write-Host "libusb set up and is ok"

# Clone repo and build

if (Test-Path C:\github) {
    $githubdirpriorexist = $true
    cd C:\github
    mkdir $rundatetime
    cd $rundatetime
    }
else {
    mkdir github
    cd C:\github
    mkdir $rundatetime
    cd $rundatetime
    }

#start build block
$env:Path += ";C:\Qt\5.15.0\mingw81_64\bin;C:/Qt/Tools/mingw810_64\bin"
#git clone https://github.com/simoninns/DomesdayDuplicator.git
git clone https://github.com/TokugawaHeavyIndustries/DomesdayDuplicator.git
cd DomesdayDuplicator\Linux-Application\DomesdayDuplicator
qmake
make all
make install
windeployqt C:\github\$rundatetime\DomesdayDuplicator\Linux-Application\DomesdayDuplicator\release
#endbuildblock

# Copy release out and clean up

Write-Host "Where would you like the release saved?"
Write-Host "Default: C:\DomesdayDuplicator"
Write-Host "NOTE!  If this directory already exists, it will be overwritten!"
Write-Host ""
$finalreleasedir = Read-Host
if ([string]::IsNullOrWhiteSpace($finalreleasedir)) {
$finalreleasedir = ‘C:\DomesdayDuplicator’
}

Copy-Item -Path C:\github\$rundatetime\DomesdayDuplicator\Linux-Application\DomesdayDuplicator\release\* -Destination $finalreleasedir -Recurse
cd $finalreleasedir

if ($githubdirpriorexist -eq $false) {
    Remove-Item C:\github -Recurse -Force
    }
if ($githubdirpriorexist -eq $true) {
    Remove-Item C:\github\$rundatetime -Recurse -Force
    }