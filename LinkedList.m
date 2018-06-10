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

#import "LinkedList.h"

@implementation LinkedList
-(id) free
{
	[self clear];
	return [super free];
}
-(id) add: (id)item
{
	return [self add: item At: size]; //just a special case alias
}
-(IDDoubleNode*) nodeAt: (int)index
{
	if(head == nil || index < 0 || index >= size)
	{
		return nil;
	}
	//index is either head, tail, cursor, or in between:
	//0 - - crsr - - size
	if(index == 0){			//head
		cursor = head;
		crsr = 0;
		return head;
	}
	if(index == (size - 1)){	//tail
		cursor = tail;
		if((crsr = size - 1) < 0)
			crsr = 0;
		return tail;
	}
	if(index == crsr){		//cursor
		return cursor;
	}
	int i, d;
	if(index < crsr){		//in between
		if(index < (crsr - index)){
			i = 0; d = 1;
			cursor = head;
			crsr = 0;
		}
		else{
			i = crsr; d = -1; //cursor stays the same
		}
	}
	else{
		if((index - crsr) < (size - 1 - index)){
			i = crsr; d = 1; //cursor stays the same
		}
		else{
			i = size - 1; d = -1;
			cursor = tail;
			crsr = size - 1;
		}
	}
	for(; i != index; i = i + d)
	{
		if(d < 0)
			cursor = [cursor getPrev];
		if(d > 0)
			cursor = [cursor getNext];
		crsr = crsr + d;
		if(d == 0)
			return nil; //there's been an error, should be either + or -
	}
	return cursor;
}
-(id) at: (int)index
{
	return [[self nodeAt: index] getData]; //should be able to send messages to nil if nodeAt returns it
}
-(id) add: (id)item At: (int)index
{
	IDDoubleNode* temp_prev, * temp, * new_node;
	temp = [self nodeAt: index];
	if(temp == nil)
	{
		if(index == 0){	//head must have been nil, so empty list
			head = [IDDoubleNode newWithData: item];
			tail = head;
			cursor = head;
			crsr = 0;
			size++;
			return self;
		}
		if(index == size){ //position just past tail; out of bounds for nodeAt, so explains temp==nil
			temp = [IDDoubleNode newWithData: item];
			[tail setNext: temp];
			[temp setPrev: tail];
			tail = temp;
			cursor = tail;
			crsr = size;
			size++;
			return self;
		}
		return nil; //something bad must have happened...
	}
	new_node = [IDDoubleNode newWithData: item];
	temp_prev = [temp getPrev];
	[new_node setPrev: temp_prev];
	[new_node setNext: temp];
	[temp_prev setNext: new_node];
	[temp setPrev: new_node];
	cursor = new_node;
	crsr = index;
	size++;
	return self;
}
//Internal Notes (-includes)
//Postcondition is that cursor (and thereby crsr) will be pointing either to the first occurrence of
//the provided item, or it will be pointing to the tail (these two could coincide!), or in the case of
//an empty list, could be pointing to nil (we all knew that).  STICK TO THIS!!!
-(BOOL) includes: (id)item
{
	cursor = head;
	crsr = 0;
	while(cursor != nil)
	{
		if([[cursor getData] isEqualTo: item])
		{
			return YES;
		}
		cursor = [cursor getNext];
		crsr++;
	}
	cursor = tail;	//reset the cursor to the tail, since it should point to nil at this point
	crsr = size - 1;//ditto with crsr (the index)	IF SIZE==0, WILL CRSR BE -1?
	return NO;
}
-(id) remove: (id)item //assumes item implements isEqualTo:
{
	if(size == 0) 
		return nil;
	if([self includes: item] == YES) {	//this hinges on -includes setting the cursor properly
		size = size - 1;
		IDDoubleNode* temp_prev = [cursor getPrev];
		IDDoubleNode* temp_next = [cursor getNext];
		[temp_prev setNext: temp_next];
		[temp_next setPrev: temp_prev];
		[cursor delete];
		if(temp_prev == nil) {	//head case
			head = temp_next; //okay if this is nil too
		}
		cursor = head;	//default behavior is that after this operation, the cursor points at the head,
		crsr = 0;	//which has been adjusted in case of it being removed (or the list size is 0, so it's
	}			//nil anyways.

	/*
	if([[head getData] isEqualTo: item])	//check head
	{
		cursor = head;
		head = [head getNext];
		[cursor delete];
		cursor = head;
		crsr = 0;
		size--;
		if(size == 0)
		{
			tail = nil;
		}
		return self;
	}
	cursor = [cursor getNext]; //since head was already checked
	crsr++;
	while(cursor != nil)
	{
		if([[cursor getData] isEqualTo: item])
		{
			break;
		}
		cursor = [cursor getNext];
		crsr++;
	}
	if(cursor != nil)//i.e. we found it, so get rid of it
	{
		IDDoubleNode* temp_prev = [cursor getPrev];
		IDDoubleNode* temp_next = [cursor getNext];
		[temp_prev setNext: temp_next];
		if(temp_next != nil)
		{
			[temp_next setPrev: temp_prev];
		}
		[cursor delete];
		cursor = temp_prev;
		crsr--; //since we're moving everything to the previous node (we know head is valid)
	}
	*/
	return self;
}
-(id) delete: (id)item
{
	if(size == 0) 
		return nil;	
	if([self includes: item] == YES) {	//this hinges on -includes setting the cursor properly
		size = size - 1;
		IDDoubleNode* temp_prev = [cursor getPrev];
		IDDoubleNode* temp_next = [cursor getNext];
		[temp_prev setNext: temp_next];
		[temp_next setPrev: temp_prev];
		[[cursor getData] delete];
		[cursor delete];
		if(temp_prev == nil) {	//head case
			head = temp_next; //okay if this is nil too
		}
		if(temp_next == nil) {	//tail case
			tail = temp_prev; //also okay if nil; head and tail should be equivalent in that case
		}
		cursor = head;	//default behavior is that after this operation, the cursor points at the head,
		crsr = 0;	//which has been adjusted in case of it being removed (or the list size is 0, so it's
	}			//nil anyways.
	/*
	if([[head getData] isEqualTo: item])	//check head
	{
		head = [head getNext];
		[[cursor getData] delete];
		[cursor delete];
		cursor = head;
		crsr = 0;
		size--;
		if(size == 0)
			tail = nil;
		return self;
	}
	cursor = [cursor getNext]; //since head was already checked
	while(cursor != nil)
	{
		if([[cursor getData] isEqualTo: item])
		{
			break;
		}
		cursor = [cursor getNext];
		crsr++;
	}
	if(cursor != nil)//i.e. we found it, so get rid of it
	{
		IDDoubleNode* temp_prev = [cursor getPrev];
		IDDoubleNode* temp_next = [cursor getNext];
		[temp_prev setNext: temp_next];
		if(temp_next != nil)
		{
			[temp_next setPrev: temp_prev];
		}
		[[cursor getData] delete];
		[cursor delete];
		cursor = temp_prev;
		crsr--; //since we're moving everything to the previous node (we know head is valid)
	}
	*/
	return self;
}
-(id) removeAll: (id)item
{
	if(size == 0) 
		return nil;
	BOOL checker = YES;
	while(size > 0 && checker == YES)	
	{
		checker = NO;
		if([[head getData] isEqualTo: item])	//check head
		{
			head = [head getNext];
			[cursor delete];
			cursor = head;
			crsr = 0;
			size--;
			if(size == 0)
			{
				tail = nil;
			}
			checker = YES;
		}
	}
	IDDoubleNode* temp_prev;
	IDDoubleNode* temp_next;
	while(cursor != nil)
	{
		cursor = [cursor getNext];
		if([[cursor getData] isEqualTo: item])
		{
			temp_prev = [cursor getPrev];
			temp_next = [cursor getNext];
			[temp_prev setNext: temp_next];
			if(temp_next != nil)
			{
				[temp_next setPrev: temp_prev];
			}
			[cursor delete];
			cursor = temp_prev;
		}
		crsr++;
	}
	cursor = tail; //move cursor back to the end of the list
	crsr = size - 1;
	return self;
}
-(id) deleteAll: (id)item
{
	BOOL checker = YES;
	while(size > 0 && checker == YES)	
	{
		checker = NO;
		if([[head getData] isEqualTo: item])	//check head
		{
			head = [head getNext];
			[[cursor getData] delete];
			[cursor delete];
			cursor = head;
			crsr = 0;
			size--;
			if(size == 0)
			{
				tail = nil;
			}
			checker = YES;
		}
	}
	IDDoubleNode* temp_prev;
	IDDoubleNode* temp_next;
	while(cursor != nil)
	{
		cursor = [cursor getNext];
		if([[cursor getData] isEqualTo: item])
		{
			temp_prev = [cursor getPrev];
			temp_next = [cursor getNext];
			[temp_prev setNext: temp_next];
			if(temp_next != nil)
			{
				[temp_next setPrev: temp_prev];
			}
			[[cursor getData] delete];
			[cursor delete];
			cursor = temp_prev;
		}
		crsr++;
	}
	cursor = tail; //move cursor back to the end of the list
	crsr = size - 1;
	return self;
}
-(id) removeAt: (int)index
{
	if(size == 0)
		return self;
	IDDoubleNode* node;
	size--;
	if(index == 0)	//head	//update cursor in circumstances like this?
	{
		node = head;
		head = [node getNext];
		[node delete];
		return self;
	}
	if(index == size) //tail, we refer just to size since it has already been decremented
	{
		printf("here\n");
		node = tail;
		tail = [node getPrev];
		[node delete];
		[tail setNext: nil];
		return self;
	}
	node = [self nodeAt: index];
	if(node == nil)
	{
		return nil;
	}
	IDDoubleNode* temp_prev = [node getPrev];
	IDDoubleNode* temp_next = [node getNext];
	[temp_prev setNext: temp_next];
	[temp_next setPrev: temp_prev];
	[node delete];
	return self;
}
-(id) deleteAt: (int)index
{
	if(size == 0)
		return self;
	IDDoubleNode* node;
	size--;
	if(index == 1)	//head	//update cursor in circumstances like this?
	{
		node = head;
		head = [node getNext];
		[[node getData] delete];
		[node delete];
		return self;
	}
	if(index == (size - 1)) //tail
	{
		node = tail;
		tail = [node getPrev];
		[[node getData] delete];
		[node delete];
		[tail setNext: nil];
		return self;
	}
	node = [self nodeAt: index];
	if(node == nil)
	{
		return nil;
	}
	IDDoubleNode* temp_prev = [node getPrev];
	IDDoubleNode* temp_next = [node getNext];
	[temp_prev setNext: temp_next];
	[temp_next setPrev: temp_prev];
	[[node getData] delete];
	[node delete];
	return self;
}
-(id) clear
{
	cursor = head;
	IDDoubleNode* temp;
	while(cursor != nil)
	{
		temp = [cursor getNext];
		[cursor delete];
		cursor = temp;
	}
	size = 0;
	head = nil;
	tail = head;
	return self;
}
-(id) erase //makes the assumption that the items in the list are Base descendants
{
	cursor = head;
	IDDoubleNode* temp;
	while(cursor != nil)
	{
		temp = [cursor getNext];
		[[cursor getData] delete];
		[cursor delete];
		cursor = temp;
	}
	size = 0;
	head = nil;
	tail = head;
	return self;
}
-(BOOL) isEmpty
{
	if(size == 0)
		return YES;
	return NO;
}
-(int) size
{
	return size;
}
-(int) length
{
	return [self size];
}
@end
