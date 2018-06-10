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

#import "IntAssoc.h"

@implementation IntAssoc
-(id) initWithKey: (id)asKey Value: (int)asValue
{
	if((self = [super init]))
	{
		key = asKey;
		value = asValue;
		return self;
	}
	return nil;
}
+(id) newWithKey: (id)asKey Value: (int)asValue
{
	return [[self alloc] initWithKey: asKey Value: asValue];
}
-(id) key
{
	return key;
}
-(int) value
{
	return value;
}
-(id) inc
{
	if(value < 0)
		value = 0;
	else
		value++;
	return self;
}
-(id) dec
{
	if(value > 0)
		value--;
	return self;
}
-(id) set: (int)asVal
{
	if(asVal >= 0)
	{
		value = asVal;
	}
	return self;
}
-(id) clear
{
	value = 0;
	return self;
}
@end
