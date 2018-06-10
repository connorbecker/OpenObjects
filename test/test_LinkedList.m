#import <OpenObjects.h>
#include <stdio.h>

void fillList(LinkedList* toFill);
void printList(LinkedList* toPrint);

int main(int argc, char* argv[])
{
	LinkedList* list = [LinkedList new];
	int i;

	printf("/* Test add: */\n");
	fillList(list);
	printList(list);

	printf("/* Test: clear */\n");
	[list clear];
	printList(list);
	fillList(list);

	printf("/* Test at: */\n");
	printList(list);
	if([list at: -1] != nil)
	{
		printf("Should be nil. Sent it -1 didn't I!?\n");
	}
	if([list at: [list length] + 1] != nil)
	{
		printf("Should be nil.  Index is too big.  Yeah, I checked!\n");
	}
	[list clear];
	printf("/* Test: removing items */\n");
	fillList(list);
	printList(list);
	printf("-----\n");
	for(i = 0; i < [list length]; i++)
	{
		[list removeAt: 0];
	}
//	[list removeAt: 4];
//	[list removeAt: 1];
//	[list removeAt: 1];
//	[list removeAt: 1];
//	[list remove: @"hihi!"];
//	[list removeAt: 0];
	printf("-----\n");
	printList(list);
	printf("-----\n");
	[list clear];
	printList(list);

	/* Test: deleting items */
	fillList(list);

	return 0;
}

void fillList(LinkedList* toFill)
{
	[toFill add: @"heya!"];
	[toFill add: @"hihi!"];
	[toFill add: @"hola!"];
	[toFill add: @"Go-go gadget metric yardstick!"];
	[toFill add: @"Dang, Eureka's over..."];
}

void printList(LinkedList* toPrint)
{
	char* temp;
	int i, limit = [toPrint length];
	for(i = 0; i < limit; i = i + 1)
	{
		temp = [[toPrint at: i] asCString];
		printf("%s\n", temp);
		free(temp);
	}
}
