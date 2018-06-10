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

#import "Collection.h"

//List!! is a protocol that abstracts the concept of an ordered, automatically resizing collection of objects.
//The ordering is keyed to the natural numbers (0, 1, ..., n - 1, n); the number of the items in a list is
//referred to as its length. Although any object can be added to the list, several methods are described as
//sending specific messages (namely -delete) to the contained objects, thereby assuming that they descend from
//@Base. The implementations for the methods, however, could perform memory management in their own way, thus
//bypassing that assumption.
@protocol List <Collection>
//Adds the provided item to the end of the list
//@param item any object
//-(id) add: (id)item;
//
//Retrieves an item from the list at the provided index
//@param index the offset of the desired item
//@return the specified item, or /nil/ if index less than 0 or greater than the number of items in the list
-(id) at: (int)index;
//
//Adds the provided item to the list at the provided index, moving the remaining items (if any) a position back
//@param item any object
//@param index the desired 0-based offset, up to and including size!!
-(id) add: (id)item At: (int)index;
//
//Removes the first occurrence of the given object, if any
//@param item any object
//-(id) remove: (id)item;
//
//Removes the first occurrence of the given object (if any) and sends it a -delete message
//@param item any object
-(id) delete: (id)item;
//
//Removes all occurrences of the given object, if any
//@param item any object
-(id) removeAll: (id)item;
//
//Removes all occurrences of the given object and sends a -delete message to each of them
//@param item any object
-(id) deleteAll: (id)item;
//
//Removes the item at the given index
//@param index the offset of the desired item
-(id) removeAt: (int)index;
//
//Removes the item at the given index and sends it a -delete message
//@param index the offset of the desired item
-(id) deleteAt: (int)index;
//
//Removes all items in the list
//-(id) clear;
//
//Removes all items in the list, sending a -delete message to each of them
-(id) erase;
//
//Retrieves the number of items in the list
//@return the number of items in the list
//-(int) size;
//
//Retrieves the number of items in the list (an alias of -size, for semantic value)
//@return the number of items in the list
-(int) length;
@end
