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

//IDNode!! is a class that creates objects that act as linkable containers. One may store any object in an IDNode object, and then point it at another
//IDNode object. The most common use for these objects is to form them into a singly-linked list.
@interface IDNode : Base
{
	id data;	//The contained object
	IDNode* next;	//A reference to another /IDNode/
}

/* Instance Creation, Initialization, and Destruction */

//Initializes a new /IDNode/ object to contain the provided object
//@param obj any object
-(id) initWithData: (id)obj;
//
//One-step Alocation & Initialization of a new /IDNode/ object to contain the provided object
//@param obj any object
+(id) newWithData: (id)obj;

/* Basic Operations */

//Places the provided object in the /IDNode/'s container
//@param obj any object
-(id) setData: (id)obj;
//
//Retrieves the object contained in the /IDNode/
-(id) getData;
//
//Sets the /IDNode/'s pointer to the provided /IDNode/ pointer
//@param pointer a pointer to an /IDNode/
-(id) setNext: (IDNode*)pointer;
//
//Retrieves the /IDNode/ pointed to by this /IDNode/
//@return a pointer to an /IDNode/
-(IDNode*) getNext;
@end
