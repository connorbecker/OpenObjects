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
#import "File.h"
#import "FileReader.h"
#import "FileWriter.h"
#import "TextInStream.h"
#import "TextOutStream.h"

@interface Transcript : Base <TextInStream, TextOutStream>
{
	FileReader* fr;
	FileWriter* fw;
}
-(id) init;
-(id) free;
-(id) setIn: (File*)toReadFrom;
-(id) setOut: (File*)toWriteTo;
-(id) writeChar: (char)toWrite;
-(id) writeC: (char*)toWrite;
-(id) write: (String*)toWrite;
-(id) writeCLine: (char*)toWrite;
-(id) writeLine: (String*)toWrite;
-(id) cr;
-(id) newLine;
-(char) readChar;
-(String*) readUntil: (char)lastChar;
-(char*) readCLine;
-(String*) readLine;
-(id) nextLine;
-(BOOL) isFinished;
@end
