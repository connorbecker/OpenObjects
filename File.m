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

#import "File.h"

@implementation File
-(id) init
{
	self = [super init];
	return self;
}
-(id) initFromCString: (char*)fileName
{
	name = fileName;
	return [self init];
}
-(id) initFromString: (String*)fileName
{
	name = [fileName asCString];
	return [self init];
}
-(id) initFromStdIn
{
	name = "STDIN";
	fp = stdin;
	return [self init];
}
-(id) initFromStdOut
{
	name = "STDOUT";
	fp = stdout;
	return [self init];
}
-(id) initFromStdErr
{
	name = "STDERR";
	fp = stderr;
	return [self init];
}
+(id) newFromCString: (char*)fileName
{
	return [[self alloc] initFromCString: fileName];
}
+(id) newFromString: (String*)fileName
{
	return [[self alloc] initFromString: fileName];
}
+(id) newFromStdIn
{
	return [[self alloc] initFromStdIn];
}
+(id) newFromStdOut
{
	return [[self alloc] initFromStdOut];
}
+(id) newFromStdErr
{
	return [[self alloc] initFromStdErr];
}
-(String*) name
{
	return [String newFromCString: name];
}
-(char*) cName
{
	char* toReturn = malloc((strlen(name) + 1) * sizeof(char));
	return strcpy(toReturn, name);
}
-(FILE*) getFilePointer
{
	return fp;
}
-(BOOL) isOpen
{
	if(fp == NULL)
	{
		return NO;
	}
	return YES;
}
-(BOOL) isClosed;
{
	return ![self isOpen];
}
-(id) openR
{
	if([self isClosed])
	{
		fp = fopen(name, "r");
	}
	return self;
}
-(id) openW
{
	if([self isClosed])
	{
		fp = fopen(name, "w");
	}
	return self;
}
-(id) openRW
{
	if([self isClosed])
	{
		fp = fopen(name, "w+");
	}
	return self;
}
-(id) openA
{
	if([self isClosed])
	{
		fp = fopen(name, "a");
	}
	return self;
}
-(id) openRA
{
	if([self isClosed])
	{
		fp = fopen(name, "a+");
	}
	return self;
}
-(id) close
{
	fclose(fp);
	fp = NULL;
	return self;
}
-(id) make
{
	//should be fine to open the file for reading if it hasn't already been opened
	if([self isClosed])
	{
		fp = fopen(name, "r");
		fclose(fp);
	}
	return self;
}
-(id) kill
{
	remove(name);
	return self;
}
-(id) free
{
	if(fp != NULL)
	{
		fclose(fp);
	}
	return self;
}
@end
