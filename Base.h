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

#import <objc/objc.h>
#import <objc/runtime.h>

@interface Base
{
	Class class_pointer;
}
/* Class Initializer */
+(id) initialize;		//Initialize the class itself

/* Instance Creation, Initialization, and Destruction */
+(id) alloc;			//Create a new instance of this class
-(id) init;			//Initialize an instance of this class
+(id) new;			//Alias for [[... alloc] init]
-(id) free;			//Free resources held by an instance of this class
-(id) dealloc;			//Destroy the instance of the class
-(id) delete;			//Alias for [[... free] dealloc]

//Instance Utilities
-(id) self;			//Returns a reference to the object
-(Class) class;			//Returns a reference to the object's class
-(Class) superclass;		//Returns a reference to the object's superclass
-(BOOL) isEqualTo: (id)anObject;//Determines whether anObject is equal to the object
-(BOOL) equals: (id)anObject;	//Alias for -isEqualTo:
-(BOOL) isMetaclass;		//Determines whether the object is a metaclass
-(BOOL) isClass;		//Determines whether the object is a class
-(BOOL) isInstance;		//Determines whether the object is an instance of a class
-(BOOL) inherits: (Class)aClass;//Determines whether the object is an instance or a subclass of aClass
-(BOOL) isA: (Class)aClass;	//Determines whether the object is a member of the aClass class
@end
