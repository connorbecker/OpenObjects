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

#import "Bag.h"

@implementation Bag
-(id) add: (id)anItem
{
	IntAssoc* temp;
	int i, limit = [back size];
	for(i = 0; i < limit; i++)
	{
		temp = [back at: i];
		if([[temp key] isEqualTo: anItem])
		{
			[temp inc];
			break;
		}
	}
	return self;
}
-(id) remove: (id)anItem
{
	IntAssoc* temp;
	int i, limit = [back size];
	for(i = 0; i < limit; i++)
	{
		temp = [back at: i];
		if([[temp key] isEqualTo: anItem])
		{
			[temp dec];
			if([temp value] <= 0)
			{
				[back deleteAt: i]; //TEMP IS NOW INVALID
			}
			break;
		}
	}
	return self;
}
-(BOOL) includes: (id)anItem
{
	int i, limit = [back size];
	for(i = 0; i < limit; i++)
	{
		if([[[back at: i] key] isEqualTo: anItem])
		{
			return YES;
		}
	}
	return NO;
}
-(BOOL) isEmpty
{
	return [back isEmpty];
}
-(int) size
{
	return [back size];
}
@end
