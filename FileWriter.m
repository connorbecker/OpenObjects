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

#import "FileWriter.h"

@implementation FileWriter
-(id) initFromFile: (File*)file_obj
{
	if((self = [super init]))
	{
		file = file_obj;
		[file openW];
		return self;
	}
	return nil;
}
-(id) initFromCString: (char*)fileName
{
	return [self initFromFile: [File newFromCString: fileName]];
}
-(id) initFromString: (String*)fileName
{
	return [self initFromCString: [fileName asCString]];
}
+(id) newFromFile: (File*)file_obj
{
	return [[FileWriter alloc] initFromFile: file_obj];
}
+(id) newFromCString: (char*)fileName
{
	return [[FileWriter alloc] initFromCString: fileName];
}
+(id) newFromString: (String*)fileName
{
	return [[FileWriter alloc] initFromString: fileName];
}
-(id) free
{
	[file free];
	return self;
}
-(id) writeChar: (char)toWrite
{
	int rc = fputc(toWrite, [file getFilePointer]);
	if(rc == EOF)
	{
		return nil;
	}
	return self;
}
-(id) write: (String*)toWrite
{
	char* temp = [toWrite asCString];
	[self writeC: [toWrite asCString]];
	free(temp);
	return self;
}
-(id) writeC: (char*)toWrite
{
	int rc = fprintf([file getFilePointer], "%s", toWrite);
	if(rc < 0)	//error
	{
		return nil;
	}
	return self;
}
-(id) writeLine: (String*)toWrite
{
	char* temp = [toWrite asCString];
	[self writeCLine: [toWrite asCString]];
	free(temp);
	return self;
}
-(id) writeCLine: (char*)toWrite
{
	int rc1 = fputs(toWrite, [file getFilePointer]);
	int rc2 = fputc('\n', [file getFilePointer]);
	if(rc1 == EOF || rc2 == EOF)	//error
	{
		return nil;
	}
	return self;
}
-(id) cr
{
	int rc = fputc('\n', [file getFilePointer]);
	if(rc == EOF)
	{
		return nil;
	}
	return self;
}
-(id) newLine
{
	return [self cr];
}
@end
