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

#import "Stack.h"

@implementation Stack
-(id) free
{
	[self clear];
	return [super free];
}
-(id) push: (id)item
{
	IDNode* newtop = [IDNode newWithData: item];
	[newtop setNext: top];
	top = newtop;
	size = size + 1;
	return self;
}
-(id) peek
{
	if(top != nil)
	{
		return [top getData];
	}
	return nil;
}
-(id) pop
{
	IDNode* cursor = top;
	id toReturn;
	if(top == nil)
	{
		return nil;
	}
	else
	{
		top = [top getNext];
		toReturn = [cursor getData];
		[cursor delete];
		size = size - 1;
		return toReturn;
	}
}
-(id) clear
{
	IDNode* toFree = top;
	IDNode* cursor;
	while(toFree != nil)
	{
		cursor = [toFree getNext];
		[toFree delete];
		toFree = cursor;
	}
	size = 0;
	return self;
}
-(id) erase
{
	IDNode* toFree = top;
	IDNode* cursor;
	while(toFree != nil)
	{
		cursor = [toFree getNext];
		[[toFree getData] delete];
		[toFree delete];
		toFree = cursor;
	}
	size = 0;
	return self;
}
-(int) size
{
	return size;
}
@end
