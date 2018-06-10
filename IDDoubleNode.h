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

//IDDoubleNode!! is a class that creates objects that act as doubly linkable containers. The difference between this class and its superclass is that /IDDoubleNode/
//contains a second link; using the concept of a chain, the /IDDoubleNode/ can point at both the next /and/ the previous /IDDoubleNode/ in the chain. The obvious
//common use of objects of this class would be to form them into a doubly-linked list.
@interface IDDoubleNode : IDNode
{
	IDDoubleNode* previous;	//A reference to another /IDDoubleNode/
}

/* Basic Operations */

//Retrieves the /IDNode/ pointed to by this /IDNode/
//@return a pointer to an /IDNode/
-(IDDoubleNode*) getNext;
//
//Sets the /IDDoubleNode/'s second pointer (e.g. the "previous" pointer)
//@param prevpointer a pointer to an /IDDoubleNode/
-(id) setPrev: (IDDoubleNode*)prevpointer;
//
//Retrieves the second /IDDoubleNode/ pointed to by this /IDDoubleNode/
//@return the second /IDDoubleNode/ pointer
-(IDDoubleNode*) getPrev;
@end
