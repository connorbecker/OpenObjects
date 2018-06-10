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
#import "TextOutStream.h"

//FileWriter!! is a class used to create objects that logically "write" text files from the user filesystem using objects of the @File class, either
//as provided, or internally created using a provided file name.
@interface FileWriter : Base <TextOutStream>
{
	File* file;	//A @File object
}

/* Instance Creation, Initialization, and Destruction */

//Initializes a new /FileWriter/ object using the provided @File object
//@param file_obj a usable @File object
-(id) initFromFile: (File*)file_obj;
//
//Initializes a new /FileWriter/ object using the provided C string as a file name
//@param fileName a valid file name
-(id) initFromCString: (char*)fileName;
//
//Initializes a new /FileWriter/ object using the provided String as a file name
//@param fileName a valid file name
-(id) initFromString: (String*)fileName;
//
//One-step Allocation & Initialization of a new /FileWriter/ object using the provided @File object
//@param file_obj a usable @File object
+(id) newFromFile: (File*)file_obj;
//
//One-step Allocation & Initialization of a new /FileWriter/ object using the provided C string as a file name
//@param fileName a valid file name
+(id) newFromCString: (char*)fileName;
//
//One-step Allocation & Initialization of a new /FileWriter/ object using the provided String as a file name
//@param fileName a valid file name
+(id) newFromString: (String*)fileName;
//
//Safely releases any resources held by the object
-(id) free;

/* Basic Operations */

//Logically writes the provided character to the file
//@param toWrite a character
-(id) writeChar: (char)toWrite;
//
//Logically writes the provided String to the file
//@param toWrite a String
-(id) write: (String*)toWrite;
//
//Logically writes the provided C string to the file
//@param toWrite a C string
-(id) writeC: (char*)toWrite;
//
//Logically writes the provided String to the file followed by a newline character
//@param toWrite a String
-(id) writeLine: (String*)toWrite;
//
//Logically writes the provided C string to the file followed by a newline character
//@param toWrite a C string
-(id) writeCLine: (char*)toWrite;
//
//Logically writes a newline (e.g. carriage return) to the file
-(id) cr;
//
//Logically writes a newline (e.g. carriage return) to the file (alias of -cr)
-(id) newLine;
@end
