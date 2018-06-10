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

#import "Queue.h"

@implementation Queue
-(id) free
{
	[self clear];
	return [super free];
}
-(id) push: (id)item
{
	IDNode* newitem = [IDNode newWithData: item];
	if(back == nil)
	{
		front = newitem;
		back = front;
	}
	else
	{
		[back setNext: newitem];
		back = [back getNext];
	}
	size = size + 1;
	return self;
}
-(id) peek
{
	if(front != nil)
	{
		return [front getData];
	}
	return nil;
}
-(id) pull
{
	IDNode* toFree = front;
	id toReturn = nil;
	if(front != nil)
	{
		toReturn = [front getData];
		front = [front getNext];
		size = size - 1;
		[toFree delete];
	}
	return toReturn;
}
-(id) clear
{
	IDNode* toFree = front;
	IDNode* cursor;
	while(toFree != nil)
	{
		cursor = [toFree getNext];
		[toFree delete];
		toFree = cursor;
	}
	size = 0;
	back = front;
	return self;
}
-(id) erase
{
	IDNode* toFree = front;
	IDNode* cursor;
	while(toFree != nil)
	{
		cursor = [toFree getNext];
		[[toFree getData] delete];
		[toFree delete];
		toFree = cursor;
	}
	size = 0;
	back = front;
	return self;
}
-(int) size
{
	return size;
}
@end
