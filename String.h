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
#import "TextInStream.h"
#include <string.h>
#include <sys/types.h>
#include <stdlib.h>
#include <ctype.h>

//String!! is a class that creates objects representing immutable sequences of characters.
@interface String : Base <TextInStream>
{
	char* c_string;		//A C string for backend use
	unsigned int len;	//Total number of characters
	int cursor;		//A private cursor, for TextInStreams compatibility
}

/* Instance Creation, Initialization, and Destruction */

//Failsafe initializer for newly created instances; can be used to create an empty ("") string
-(id) init;
//
//Initializes a newly created instance setting its value to the given C style string
-(id) initFromCString: (char*)cstring;
//
//Initializes a newly created instance setting its value to the value of the given String
-(id) initFromString: (String*)string;
//
//Creates and initializes an instance setting its value to the given C style string
+(id) newFromCString: (char*)cstring;
//
//Creates and initializes an instance setting its value to the value of the given String
+(id) newFromString: (String*)string;
//
//Safely releases any resources held by the instance. /This should not be called on a literal String!/
-(id) free;

/* Basic Operations */

//Retrieves the character at the given position
//@param pos the desired 0-based index
//@return the specified character, or the NULL character if pos is less than 0 or greater than the length of the string
-(char) at: (int)pos;
//
//Retrieves a substring starting at index 'start' and ending at index 'end'
//@param start the index at which to start
//@param end the index at which to end
//@return a String representing the substring; /nil/ if 'start' or 'end' are out-of-bounds
-(String*) from: (int)start To: (int)end;
//
//Retrieves a substring starting at index 'start' and continuing for 'length' characters
//@param start the index at which to start
//@param length the number of characters to include
//@return the substring, or /nil/ if 'start' is out-of-bounds or length is too long
-(String*) from: (int)start For: (int)length;
//
//Searches the string for the first occurrence of the given string
//@param toFind the substring for which to look
//@return the index of the beginning of the first occurrence, or -1 if not found
-(int) find: (String*)toFind;
//
//Searches the string starting at the given position for the first occurrence of the given string
//@param toFind the substring for which to look
//@param pos the starting point of the search
//@return the index of the beginning of the first occurrence, or -1 if not found
-(int) find: (String*)toFind After: (int)pos;
//
//Similar to -find, searches the string for the last occurrence of the provided string
-(int) findLast: (String*)toFind;
//
//Similar to -find:After, searches the string backwards from the provided index, and returns position of the
//first occurrence of the provided string that it finds.
-(int) find: (String*)toFind Before: (int)pos;
//
//Compares the instance to another object.
//@param comparand the object to compare
//@return a boolean representing whether the object is equivalent to the instance--this automatically throws out any non-string descending objects.
-(BOOL) isEqualTo: (id)comparand;
//
//Checks whether the string is indeed an empty string
//@return a boolean representing whether the string is empty or not
-(BOOL) isEmpty;
//
//Creates a new string by adding the given string to the end of the instance
//@param toAdd the String object to be added
//@return a new String object the value of which is the strings added together
-(String*) plus: (String*)toAdd;
//
//Retrieves a standard C style string representation of the String
//@return a C style string
-(char*) asCString;
//
//Creates a String object representing the instance containing all uppercase letters
//@return an all-uppercase String object
-(String*) asUppercase;
//
//Creates a String object representing the instance containing all lowercase letters
//@return an all-lowercase String object
-(String*) asLowercase;
//
//Retrieves the number of characters in the String
//@return the number of characters
-(int) length;
//
//Retrieves the next character of the String, advancing the cursor 1 position (for TextInStreams compatibility)
-(char) readChar;
//
//Retrieves a String containing the characters between (and including) the cursor and the next instance of
//the provided character, or the last character if the String ends
-(String*) readUntil: (char)lastChar;
//
//Answers whether or not the cursor is at the end of the String (for TextInStreams compatibility)
-(BOOL) isFinished;
//
//Resets the cursor to the 0th character of the String
-(id) rewind;
@end
