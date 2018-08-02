::Batch file to extract certificates from PFX file. Place this in C:\SSL on the recorder
@echo off
title Extract certificate and key to the Red Box Apache web folder
mkdir C:\ssl\pfx
echo.
echo Copy PFX file into the following location: "C:\SSL\PFX"
echo.
pause
echo.
echo PFX files in this directory:
echo.
dir /B c:\ssl\pfx\*.pfx
echo.
set /p Input=Enter the file name WITHOUT the extension:
c:\ssl\openssl.exe pkcs12 -in C:\ssl\pfx\%input%.pfx -nocerts -nodes -out c:\ssl\keys\%input%.key
C:\ssl\openssl.exe rsa -in C:\ssl\keys\%input%.key -out "C:\Program Files (x86)\Apache Software Foundation\Apache2.2\conf\certs\%input%.key"
c:\ssl\openssl.exe pkcs12 -in c:\ssl\pfx\%input%.pfx -out "C:\Program Files (x86)\Apache Software Foundation\Apache2.2\conf\certs\%input%.cer"
echo.
dir /B/s "C:\Program Files (x86)\Apache Software Foundation\Apache2.2\conf\certs\%input%*"
echo.
echo The process is complete if you see 2 files, import your files within the recorder web gui and test.
echo.
del c:\ssl\keys\%input%.key
del /P c:\ssl\pfx\%input%.pfx
rmdir /S c:\ssl\pfx
pause

::To create a PFX from the key and certificate:

::openssl pkcs12 -export -out "c:\ssl\pfxsslrbrcert.pfx" -inkey c:\ssl\certs\sslrbrcert.key" -in "c:\ssl\certs\sslrbrcert.cer" -certfile
