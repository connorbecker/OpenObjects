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

#import "FileReader.h"

@implementation FileReader
-(id) initFromFile: (File*)file_obj
{
	if((self = [super init]))
	{
		file = file_obj;
		[file openR];
		return self;
	}
	return nil;
}
-(id) initFromCString: (char*)fileName
{
	if((self = [super init]))
	{
		file = [File newFromCString: fileName];
		[file openR];
	}
	return self;
}
-(id) initFromString: (String*)fileName
{
	if((self = [super init]))
	{
		file = [File newFromString: fileName];
		[file openR];
	}
	return self;
}
+(id) newFromFile: (File*)file_obj
{
	return [[self alloc] initFromFile: file_obj];
}
+(id) newFromCString: (char*)fileName
{
	return [[self alloc] initFromCString: fileName];
}	
+(id) newFromString: (String*)fileName
{
	return [[self alloc] initFromString: fileName];
}
-(char) readChar
{
	return fgetc([file getFilePointer]);
}
-(String*) readUntil: (char)lastChar
{
	MutableString* toReturn = [MutableString new];	//this is inefficient, maybe just duplicate readCLine with getdelim
	char c;
	while((c = [self readChar]) != EOF) {
		[toReturn addChar: c];
		if(c == lastChar) break;
	}
	return toReturn;
}
-(String*) readLine
{
	return [String newFromCString: [self readCLine]];
}
-(char*) readCLine
{
	char* ln;
	size_t lnlen = 0;
	int rc = getline(&ln, &lnlen, [file getFilePointer]);
	if(rc != -1)
	{
		return ln;
	}
	return NULL; //there's been some sort of error. Sends NULL instead of a possible partial line, maybe not desirable...
}
-(id) nextLine
{
	FILE* fp = [file getFilePointer];
	char c = fgetc(fp);
	while(c != '\n' && c != EOF)
	{
		c = fgetc(fp);
	}
	return self;
}
-(id) restart
{
	[file close];
	[file openR];
	return self;
}
-(BOOL) isFinished
{
	char c = fgetc([file getFilePointer]);
	if(c == EOF)
	{
		return YES;
	}
	ungetc(c, [file getFilePointer]);
	return NO;
}
-(id) free
{
	[file delete];
	return [super free];
}
@end
