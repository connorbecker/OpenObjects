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

#include <stdio.h>
#import "Base.h"
#import "File.h"
#import "String.h"
#import "MutableString.h"
#import "TextInStream.h"


//FileReader!! is a class used to create objects that logically "read" text files from the user filesystem using objects of the @File class, either
//as provided, or internally created using a provided file name.
@interface FileReader : Base <TextInStream>
{
	File* file;	//A @File object
}

/* Instance Creation, Initialization, and Destruction */

//Initializes a new /FileReader/ object using the provided @File object
//@param file_obj a usable @File object
-(id) initFromFile: (File*)file_obj;
//
//Initializes a new /FileReader/ object using the provided C string as a file name
//@param fileName a valid file name
-(id) initFromCString: (char*)fileName;
//
//Initializes a new /FileReader/ object using the provided String as a file name
//@param fileName a valid file name
-(id) initFromString: (String*)fileName;
//
//One-step Allocation & Initialization of a new /FileReader/ object using the provided @File object
//@param file_obj a usable @File object
+(id) newFromFile: (File*)file_obj;
//
//One-step Allocation & Initialization of a new /FileReader/ object using the provided C string as a file name
//@param fileName a valid file name
+(id) newFromCString: (char*)fileName;
//
//One-step Allocation & Initialization of a new /FileReader/ object using the provided String as a file name
//@param fileName a valid file name
+(id) newFromString: (String*)fileName;
//
//Safely releases any resources held by the object
-(id) free;

/* Basic Operations */

//Retrieves a character from the file and increments the logical file position
//@return the next character from the file or EOF if the file is finished
-(char) readChar;
//
//Retrieves the a String representing the next characters of the stream, up to and including the next instance
//of the provided character.
//@param lastChar the delimiting character
-(String*) readUntil: (char)lastChar;
//
//Retrieves the next line of text from the file and moves the logical file position to the next line
//@return a String containing the next line of text from the file or nil if the file is finished
-(String*) readLine;
//
//Retrieves the next line of text from the file and moves the logical file position to the next line
//@return a C string containing the next line of text from the file or NULL if the file is finished
-(char*) readCLine;
//
//Moves the logical file position to the next line
-(id) nextLine;
//
//Moves the logical file position to the beginning of the file
-(id) restart;

/* Instance Utilities */

//Retrieves the status of the logical file
//@return whether or not the logical file is at its end
-(BOOL) isFinished;
@end
