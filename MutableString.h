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

#include <ctype.h>
#import "String.h"
#import "TextOutStream.h"

//MutableString!! differs from its superclass (@String) in that it has several defined operations that mutate, or change its contents.
@interface MutableString : String <TextOutStream>
{

}

/* Basic Operations */

//Catenates the characters of the provided String object to the end of the receiver's character sequence.
//@param toAdd a String containing the characters to add
-(id) add: (String*)toAdd;
//
//Alias for -add (for TextOutStreams compliance)
-(id) write: (String*)toWrite;
//
//Catenates the provided character to the end of the receiver's character sequence
//@param toAdd the character to add
-(id) addChar: (char)toAdd;
//
//Alias for -addChar (for TextOutStreams compliance)
-(id) writeChar: (char)lastChar;
//
//Catenates the characters of the provided C string to the end of the receiver's character sequence.
//@param toAdd a C string containing the characters to add
-(id) addCString: (char*)toAdd;
//
//Replaces the first instance of the provided sample string with the provided replacement string
-(id) replace: (String*)example With: (String*)replacement;
//
//Replaces all instances of the provided sample string with the provided replacement string
-(id) replaceAll: (String*)example With: (String*)replacement;
//
//Converts the characters of the receiver to their uppercase equivalents
-(id) toUppercase;
//
//Coverts the characters of the receiver to their lowercase equivalents
-(id) toLowercase;
@end
