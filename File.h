/*
    This file is a part of OpenObjects.
    Copyright (C) 2015  C. Northcott Becker

    OpenObjects is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#import "Base.h"
#import "String.h"
#import <stdio.h>

//File!! is a class used to create objects that logically represent real files in the user filesystem.
//Usually used in conjunction with objects of the @FileReader or @FileWriter classes to perform I\/O operations.
@interface File : Base
{
	char* name;	//C string representing the name of the file
	FILE* fp;	//stdio.h style FILE pointer used internally
}

/* Instance Creation, Initialization, and Destruction */

//Failsafe initializer method; consider using another
//@return a relatively unusable object
-(id) init;
//
//Initializes new /File/ object using the provided C string as a file name
//@param fileName a valid file name
//@return an initialized object
-(id) initFromCString: (char*)fileName;
//
//Initializes a new /File/ object using the provided String as a file name
//@param fileName a valid file name
//@return an initialized object
-(id) initFromString: (String*)fileName;
-(id) initFromStdIn;
-(id) initFromStdOut;
-(id) initFromStdErr;
//
//One-step Allocation & Initialization of a new /File/ object using the provided C string as a file name
//@param fileName a valid file name
//@return an allocated and initialized object
+(id) newFromCString: (char*)fileName;
//
//One-step Allocation & Initialization of a new /File/ object using the provided String as a file name
//@param fileName a valid file name
//@return an allocated and initialized object
+(id) newFromString: (String*)fileName;
+(id) newFromStdIn;
+(id) newFromStdOut;
+(id) newFromStdErr;
//
//Safely releases any resources held by the object
-(id) free;

/* Basic Operations */

//Open logical file for /reading/ (as with fopen "r" option)
-(id) openR;
//
//Open logical file for /writing/ (as with fopen "w" option)
-(id) openW;
//
//Open logical file for /reading/ & /writing/ (as with fopen "w+" option)
-(id) openRW;
//
//Open logical file for /appending/ (as with fopen "a" option)
-(id) openA;
//
//Open logical file for /reading/ & /appending/ (as with fopen "a+" option)
-(id) openRA;
//
//Close logical file
-(id) close;
//
//Create empty file in filesystem if it does not already exist
-(id) make;
//
//Delete logical file from the filesystem if it exists
-(id) kill;

/* Instance Utilities */

//Retrieves the name of the logical file
-(String*) name;
//
//Retrieves the name of the logical file
-(char*) cName;
//
//Retrieves the raw FILE pointer used internally
//@return the FILE pointer
-(FILE*) getFilePointer;
//
//Retrieves the status of the logical file
//@return whether or not the logical file is "opened"
-(BOOL) isOpen;
//Retrieves the status of the logical file
//@return whether or not the logical file is "closed"
-(BOOL) isClosed;
@end
