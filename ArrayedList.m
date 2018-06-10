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

#import "ArrayedList.h"
#include <stdio.h> //for NULL

@implementation ArrayedList
-(id) init
{
	if((self = [super init]))
	{
		items = malloc(10 * sizeof(id)); //enough space for 10 id pointers
		size = 0;
		max = 10;
		return self;
	}
	return nil;
}
-(id) init: (int)capacity
{
	if(capacity == 0)
	{
		return [self init]; //use default initializer
	}
	if(capacity > 0 && (self = [super init]))
	{
		items = malloc(capacity * sizeof(id));
		if(items != NULL)
		{
			capacity = 0; //this should change it for the locally for the line below
		}
		size = 0;
		max = capacity;
		return self;
	}
	return nil;
}
+(id) new: (int)size
{
	return [[self alloc] init: size];
}
-(id) free
{
	[self clear];
	return [super free];
}
-(id) add: (id)item
{
	return [self add: item At: size];
}
-(id) at: (int)index
{
	if(index < 0 || index >= size)
	{
		return nil;
	}
	return items[index];
}
-(id) add: (id)item At: (int)index
{
	if(index < 0 || index > size)
	{
		return nil;
	}
	if(size == max)
	{
		id* temp;
		int temp_max = (3 * max) / 2 + 1;
		temp = realloc(items, temp_max * sizeof(id));
		//chose to use the Java 6 (3 * size) / 2 + 1) instead of just doubling
		if(temp == NULL)
		{
			return nil;
		}
		max = temp_max;
		items = temp;
	}
	int i;
	for(i = size; i > index; i--)
	{
		items[i] = items[i - 1];
	}
	items[i] = item;
	size = size + 1;
	return self;
}
-(BOOL) includes: (id)item
{
	int i;
	for(i = 0; i < size; i++)
	{
		if([items[i] isEqualTo: item])
		{
			return YES;
		}
	}
	return NO;
}
-(id) remove: (id)item //assumes item implements isEqualTo:
{
	int i;
	for(i = 0; i < size; i++) //first we find it
	{
		if([items[i] isEqualTo: item])
		{
			size = size - 1;
			break;
		} 
	}
	i = i + 1;
	for(; i <= size; i++)	//then we move everything else down
	{			//shouldn't trigger unless we found the item
		items[i - 1] = items[i];
	}
	return self;
}
-(id) delete: (id)item
{
	int i;
	for(i = 0; i < size; i = 0) //first we find it
	{
		if([items[i] isEqualTo: item])
		{
			[items[i] delete]; //only difference from -remove:
			size = size - 1;
			break;
		} 
	}
	i = i + 1;
	for(; i < size; i++)	//then we move everything else down
	{			//shouldn't trigger unless we found the item
		items[i - 1] = items[i];
	}
	return self;
}
-(id) removeAll: (id)item
{
	int i, counter = 0;
	for(i = 0; i + counter < size; i++)
	{
		if([items[i] isEqualTo: item])
		{
			counter++;
		}
		if(counter > 0)
		{
			items[i] = items[i + counter];
		}
	}
	size = size - counter;
	return self;
}
-(id) deleteAll: (id)item
{
	int i, counter = 0;
	for(i = 0; i + counter < size; i++)
	{
		if([items[i] isEqualTo: item])
		{
			[items[i] delete]; //only difference from -removeAll:
			counter++;
		}
		if(counter > 0)
		{
			items[i] = items[i + counter];
		}
	}
	size = size - counter;
	return self;
}
-(id) removeAt: (int)index
{
	if(index < 0 || index >= size)
	{
		return nil;
	}
	int i;
	for(i = index + 1; i < size; i++)
	{
		items[i - 1] = items[i];
	}
	size = size - 1;
	return self;
}
-(id) deleteAt: (int)index
{
	if(index < 0 || index >= size)
	{
		return nil;
	}
	[items[index] delete];
	int i;
	for(i = index + 1; i < size; i++)
	{
		items[i - 1] = items[i];
	}
	size = size - 1;
	return self;
}
-(id) clear	//TODO: Might be able to simplify this to just set size=0
{
	size = 0;
	return self;
}
-(id) erase //makes the assumption that the items in the list are Base descendants
{
	int i;
	for(i = 0; i < max; i++)
	{
		[items[i] delete];
	}
	size = 0;
	return self;
}
-(int) size
{
	return size;
}
-(int) length
{
	return [self size];
}
-(BOOL) isEmpty
{
	if(size == 0)
		return YES;
	else
		return NO;
}
-(int) capacity
{
	return max;
}
@end
