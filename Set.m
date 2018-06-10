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

#import "Set.h"

@implementation Set
-(id) add: (id)anItem
{
	if(![back includes: anItem])
	{
		[back add: anItem];
	}
	return self;
}
-(id) remove: (id)anItem
{
	return [back remove: anItem];
}
-(id) delete: (id)anItem
{
	return [back remove: anItem];
}
-(BOOL) includes: (id)anItem
{
	return [back includes: anItem];
}
-(id) clear
{
	return [back clear];
}
-(id) erase
{
	return [back erase];
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
