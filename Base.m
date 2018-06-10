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

@implementation Base
+(id) initialize
{
	return self;
}
+(id) alloc
{
	return class_createInstance(self, 0);
}
-(id) init
{
	return self;
}
+(id) new
{
	return [[self alloc] init];
}
-(id) free
{
	return self;
}
-(id) dealloc
{
	return object_dispose(self);
}
-(id) delete
{
	return [[self free] dealloc];
}
-(id) self
{
	return self;
}
-(Class) class
{
	return object_getClass(self);
}
-(Class) superclass
{
	return class_getSuperclass(object_getClass(self));
}
-(BOOL) isEqualTo: (id)anObject
{
	if(self == anObject)
	{
		return YES;
	}
	return NO;
}
-(BOOL) equals: (id)anObject
{
	return [self isEqualTo: anObject];
}
-(BOOL) isMetaclass
{
	return class_isMetaClass((Class)self);
}
-(BOOL) isClass
{
	return class_isMetaClass(object_getClass(self));
}
-(BOOL) isInstance
{
	return !class_isMetaClass(object_getClass(self));
}
-(BOOL) inherits: (Class)aClass
{
	//This method uses the same algorithm as the traditional gnu runtime,
	//I don't know if that's legal...
	Class cursor;
	for(cursor = object_getClass(self); cursor != nil; cursor = class_getSuperclass(cursor))
	{
		if(aClass == cursor)
		{
			return YES;
		}
	}
	return NO;
}
-(BOOL) isA: (Class)aClass
{
	if(object_getClass(self) == aClass)
	{
		return YES;
	}
	return NO;
}
@end
