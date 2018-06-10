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

#import "Transcript.h"

@implementation Transcript
-(id) init
{
	if((self = [super init]))
	{
		if(!(fr = [FileReader newFromFile: [File newFromStdIn]]))
			return nil;
		if(!(fw = [FileWriter newFromFile: [File newFromStdOut]]))
			return nil;
		return self;
	}
	return nil;
}
-(id) free
{
	[fr delete];
	[fw delete];
	return self;
}
-(id) setIn: (File*)toReadFrom;
{
	[fr delete];
	fr = [FileReader newFromFile: toReadFrom];
	if(fr == nil) return nil;
	return self;
}
-(id) setOut: (File*)toWriteTo;
{
	[fw delete];
	fw = [FileWriter newFromFile: toWriteTo];
	if(fw == nil) return nil;
	return self;
}
-(id) writeChar: (char)toWrite
{
	[fw writeChar: toWrite];
	return self;
}
-(id) writeC: (char*)toWrite
{
	[fw writeC: toWrite];
	return self;
}
-(id) write: (String*)toWrite
{
	[fw write: toWrite];
	return self;
}
-(id) writeCLine: (char*)toWrite
{
	[fw writeCLine: toWrite];
	return self;
}
-(id) writeLine: (String*)toWrite
{
	[fw writeLine: toWrite];
	return self;
}
-(id) cr
{
	return [self newLine];
}
-(id) newLine
{
	[fw newLine];
	return self;
}
-(char) readChar
{
	return [fr readChar];
}
-(String*) readUntil: (char)lastChar
{
	return [fr readUntil: lastChar];
}
-(char*) readCLine
{
	return [fr readCLine];
}
-(String*) readLine
{
	return [fr readLine];
}
-(id) nextLine
{
	return [fr nextLine];
}
-(BOOL) isFinished
{
	return [fr isFinished];
}
@end
