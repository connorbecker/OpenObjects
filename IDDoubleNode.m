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

#import "IDDoubleNode.h"

@implementation IDDoubleNode
-(IDDoubleNode*) getNext
{
	return (IDDoubleNode*)[super getNext]; //not sure this is entirely safe, as setNext: can take plain IDNodes...
}
-(id) setPrev: (IDDoubleNode*)prevpointer
{
	previous = prevpointer;
	return self;
}
-(IDDoubleNode*) getPrev
{
	return previous;
}
@end
