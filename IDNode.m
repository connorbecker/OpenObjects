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

#import "IDNode.h"

@implementation IDNode
-(id) initWithData: (id)obj
{
	if((self = [super init]))
	{
		data = obj;
	}
	return self;
}
+(id) newWithData: (id)obj
{
	return [[self alloc] initWithData: obj];
}
-(id) setData: (id)obj
{
	data = obj;
	return self;
}
-(id) getData
{
	return data;
}
-(id) setNext: (IDNode*)pointer
{
	next = pointer;
	return self;
}
-(IDNode*) getNext
{
	return next;
}
@end
