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

#import "String.h"

@implementation String
-(id) init
{
	if((self = [super init]))
	{
		c_string = malloc(sizeof(char));
		c_string[0] = '\0';
		len = 0;
	}
	return self;
}
-(id) initFromCString: (char*)cstring
{
	if((self = [super init]))
	{
		len = strlen(cstring);
		c_string = malloc((len + 1) * sizeof(char));
		strcpy(c_string, cstring);
	}
	return self;
}
-(id) initFromString: (String*)string
{
	char* ptr = [string asCString];
	[self initFromCString: ptr];
	free(ptr);
	return self;
}
+(id) newFromCString: (char*)cstring
{
	return [[self alloc] initFromCString: cstring];
}
+(id) newFromString: (String*)string
{
	return [[self alloc] initFromString: string];
}
-(id) free	//this is a problem...
{
	free(c_string);
	return [super free];
}
-(char) at: (int)pos
{
	if(pos < 0 || pos >= len)
	{
		return '\0';
	}
	return c_string[pos];
}
-(String*) from: (int)start To: (int)end
{
	if((end - start) > len)
	{
		return nil;
	}
	char* buffer = malloc((end - start + 1) * sizeof(char));
	int i;
	for(i = start; i < len && i <= end; i = i + 1)
	{
		buffer[i - start] = c_string[i];
	}
	String* toReturn = [String newFromCString: buffer];
	free(buffer);
	return toReturn;
}
-(String*) from: (int)start For: (int)length
{
	int end = start + length;
	if(end > len)
	{
		return nil;
	}
	char* buffer = malloc((length + 1) * sizeof(char));
	int i;
	for(i = start; i < end; i = i + 1)
	{
		buffer[i - start] = c_string[i];
	}
	String* toReturn = [String newFromCString: buffer];
	free(buffer);
	return toReturn;
}
-(int) find: (String*)toFind
{
	return [self find: toFind After: 0];
}
-(int) find: (String*)toFind After: (int)pos
{
	if(pos >= len || pos < 0 || [toFind length] == 0)
	{
		return -1;
	}
	char* ptr = &c_string[pos];
	char* c_toFind = [toFind asCString];
	int toReturn = strstr(ptr, c_toFind) - ptr;
	free(c_toFind);
	if(toReturn < 0)
	{
		return -1;
	}
	return toReturn;
}
-(int) findLast: (String*)toFind
{
	return [self find: toFind Before: len - 1];
}
-(int) find: (String*)toFind Before: (int)pos
{
	if(pos >= len || pos < 0 || [toFind length] == 0)
	{
		return -1;
	}
	int find_len = [toFind length];
	int last_occ = [self find: toFind After: 0];
	int temp = last_occ;
	if(last_occ == -1) return -1;
	while((temp = [self find: toFind After: last_occ + 1]) != -1 && temp + find_len <= pos)
	{
		last_occ = temp;
	}
	if(last_occ + find_len > pos) return -1;
	return last_occ;
}
-(BOOL) isEqualTo: (id)comparand
{
	if([comparand isA: [self class]])
	{
		char* ptr = [comparand asCString];
		if(strcmp(c_string, ptr) == 0)
		{
			free(ptr);
			return YES;
		}
		free(ptr);
	}
	return NO;
}
-(BOOL) isEmpty
{
	if(len == 0)
	{
		return YES;
	}
	return NO;
}
-(String*) plus: (String*)toAdd
{
	char* buffer = malloc((len + [toAdd length] + 1) * sizeof(char));
	buffer[0] = '\0';	
	strcat(buffer, c_string);
	char* toAdd_cstring = [toAdd asCString];
	strcat(buffer, toAdd_cstring);
	free(toAdd_cstring);
	String* toReturn = [String newFromCString: buffer];
	free(buffer);
	return toReturn;
}
-(char*) asCString
{
	char* toReturn = malloc((len + 1) * sizeof(char));
	strcpy(toReturn, c_string);
	return toReturn;
}
-(String*) asUppercase
{
	if(len == 0)
	{
		return [String new];
	}
	char* buffer = malloc((len + 1) * sizeof(char));
	int i;
	for(i = 0; i < len; i = i + 1)
	{
		buffer[i] = toupper(c_string[i]);
	}
	buffer[len] = '\0';
	String* toReturn = [String newFromCString: buffer];
	free(buffer);
	return toReturn;
}
-(String*) asLowercase
{
	if(len == 0)
	{
		return [String new];
	}
	char* buffer = malloc((len + 1) * sizeof(char));
	int i;
	for(i = 0; i < len; i = i + 1)
	{
		buffer[i] = tolower(c_string[i]);
	}
	buffer[len] = '\0';
	String* toReturn = [String newFromCString: buffer];
	free(buffer);
	return toReturn;
}
-(int) length
{
	return len;
}
-(char) readChar
{
	char toReturn = [self at: cursor];
	cursor++;	//doesn't matter if the cursor goes past, as -at takes care of out of bounds indexes
	return toReturn;
}
-(String*) readUntil: (char)lastChar
{
	char* ptr = c_string + cursor;
	int count = 0;
	while(cursor + count < len && ptr[count] != '\0') //using a little extra processor time so we don't have to resize memory
	{
		count++;
		if(ptr[count] == lastChar) break;
	}
	char* temp = malloc((count + 1) * sizeof(char));
	int i;
	for(i = 0; i < count; i++)
	{
		temp[i] = ptr[i];
	}
	temp[count] = '\0';
	String* toReturn = [String newFromCString: temp];
	free(temp);
	cursor = cursor + count;
	return toReturn;
}
-(BOOL) isFinished
{
	if(cursor >= len) return YES;
	return NO;
}
-(id) rewind
{
	cursor = 0;
	return self;
}
@end
