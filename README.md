# README #

Big note before getting started:  OpenObjects is *unfinished* and *buggy*.  You probably shouldn't try to use it just yet.  If that doesn't deter you...

OpenObjects is a simple, free software (GPLv3) base class library for Objective-C.  It is primarily designed to give Objective-C on GNU/Linux a small and easy-to-understand library for projects that want to avoid larger frameworks like GNUStep.

### How do I get set up? ###

## Dependencies ##
OpenObjects is designed to be used with GCC's Objective-C compiler and libobjc.  It hasn't been tested with any other systems.  The documentation system relies on the ObjCDoc package by Elmar Ludwig (available [here](http://www2.informatik.uni-osnabrueck.de/elmar/projects/objcdoc/index.html)).

##How to run tests##
To run the included tests, cd into the 'test' directory and run **./go {class name}**

##Installation##
The project comes with a Makefile; after unpacking, cd into the folder and run **make**.
If you just want the library (to run software that requires it), elevate to root and run **make install**.
If you want the library and development headers, elevate to root and run **make install-devel**.
If you want the html documentation, run **make doc** and a directory named 'doc' will be created with the documentation files.

### Contribution guidelines ###

* Writing tests
* Code review
* Other guidelines

### Who do I talk to? ###

* Repo owner or admin
* Other community or team contact