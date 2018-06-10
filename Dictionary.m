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

#import "Dictionary.h"

@implementation Dictionary
-(id) add: (id)anItem
{
	return [self addKey: anItem WithValue: nil];
}
-(id) add: (id)asValue At: (id)asKey
{
	return [self addKey: asKey WithValue: asValue];
}
-(id) addKey: (id)asKey WithValue: (id)asValue
{
	//have to manually run through due to the nature of associations...
	id temp;
	int i, limit = [back size];
	for(i = 0; i < limit; i++)
	{
		temp = [back at: i];
		if([[temp key] isEqualTo: asKey])
		{
			[temp setValue: asValue];
			return self;
		}
	}
	[back add: [IDAssoc newWithKey: asKey Value: asValue]];
	return self;
}
-(id) remove: (id)anItem
{
	id temp;
	int i, limit = [back size];
	for(i = 0; i < limit; i++)
	{
		temp = [back at: i];
		if([[temp key] isEqualTo: anItem])
		{
			[temp delete];
			return self;
		}
	}
	return self;
}
-(id) delete: (id)anItem
{
	id temp;
	int i, limit = [back size];
	for(i = 0; i < limit; i++)
	{
		temp = [back at: i];
		if([[temp key] isEqualTo: anItem])
		{
			[[temp key] delete];
			[[temp value] delete];
			[temp delete];
			return self;
		}
	}
	return self;
}
-(BOOL) includes: (id)anItem
{
	id temp;
	int i, limit = [back size];
	for(i = 0; i < limit; i++)
	{
		temp = [back at: i];
		if([[temp key] isEqualTo: anItem])
		{
			return YES;
		}
	}
	return NO;
}
-(id) at: (id)asKey
{
	id temp;
	int i, limit = [back size];
	for(i = 0; i < limit; i++)
	{
		temp = [back at: i];
		if([[temp key] isEqualTo: asKey])
		{
			return [temp value];
		}
	}
	return nil;
}
-(ArrayedList*) keys
{
	int len = [back size];
	ArrayedList* toReturn = [ArrayedList new: len];
	int i;
	for(i = 0; i < len; i++)
	{
		[toReturn add: [[back at: i] key]];
	}
	return toReturn;	
}
-(id) clear
{
	id temp;
	int i, limit = [back size];
	for(i = 0; i < limit; i++)
	{
		temp = [back at: i];
		[temp delete];
	}
	return self;
}
-(id) erase
{
	id temp;
	int i, limit = [back size];
	for(i = 0; i < limit; i++)
	{
		temp = [back at: i];
		[[temp key] delete];
		[[temp value] delete];
		[temp delete];
	}
	return self;
}
@end
