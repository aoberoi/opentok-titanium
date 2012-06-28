opentok-titanium-mobile
================
A module for the Titanium Mobile platform that uses the Opentok iOS SDK for video streaming capabilities


*WARNING*
---------
This module is not complete yet! It is still under active development.


Installation
------------
*  Currently because Opentok.framework is only compiled to be used on device in the armv7 architecture,
   you must remove armv6 from the Titanium build script. In version 1.8.2 of Titanium it is found at 
   `/Library/Application Support/Titanium/mobilesdk/osx/1.8.2/iphone/builder.py` line 1162.

*  Clone or download the repo, run `./build.py` in the directory


Notes
-----
*  Opentok.framework can be downloaded from the [official repo](https://github.com/opentok/opentok-ios-sdk)

*  Opentok will only work on device, so using scripts like `titanium run` are pretty much useless

*  Because you cannot test the module using `titanium run`, there is an [example app](https://github.com/aoberoi/OpentokHelloWorld-Titanium)
   in a separate repo. To use this app, first run `./build.py` as seen above, copy the zip file left behind into 
   `/Library/Application\ Support/Titanium/` and then build the app for your device. This will require having
   a provisioning profile from the iOS Developer Program like any other Titanium application you deploy.
   
*  open source contributions welcome :)

*  The API is currently a mix of the Opentok web API, iOS specifics, and Titanium conventions. These are subject
   to change. Suggestions welcome.


TODO
----

*  view proxies and view classes

*  assets placement

*  make Opentok.framework a git submodule


License
-------
Copyright (c) 2012 TokBox, Inc.
Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in 
the Software without restriction, including without limitation the rights to 
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies 
of the Software, and to permit persons to whom the Software is furnished to do 
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all 
copies or substantial portions of the Software.

The software complies with Terms of Service for the OpenTok platform described 
in http://www.tokbox.com/termsofservice

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE 
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE 
SOFTWARE.

