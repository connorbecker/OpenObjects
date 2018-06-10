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

#import "Base.h"
#import "IDNode.h"

//Stack!! is a class that creates objects that represent the basic First-In-First-Out queue
@interface Stack : Base
{
	IDNode* top;	//Pointer to first item on the stack
	int size;	//Total number of items
}

/* Instance Destruction */

//Safely releases any resources held by the object
-(id) free;

/* Basic Operations */

//Adds the given item to the logical top of the stack
//@param item any object
-(id) push: (id)item;
//
//Retrieves the top item of the stack
//@return the topmost item
-(id) peek;
//
//Retrieves the top item of the stack, removing it
//@return the topmost; /nil/ if empty
-(id) pop;
//
//Removes all items
-(id) clear;
//
//Removes all items and sends a -delete message to each of them
-(id) erase;
//
//Retrieves the total number of items
//@return the number of items
-(int) size;
@end
