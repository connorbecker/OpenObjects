#import <OpenObjects.h>
#include <stdio.h>

void fillList(ArrayedList* list);
void printList(ArrayedList* list);

int main(int argc, char* argv[])
{
	ArrayedList* list = [ArrayedList new: 5];

	fillList(list);
	printList(list);

	[list delete];
	list = [ArrayedList new];
	fillList(list);

	[list add: @"This is awkward..." At: 4];
	[list add: @"And here it is again..." At: [list length]];
	[list add: @"Somehow I'm up here?" At: 0];
	printList(list);
	printf("Capacity now:  %d\n", [list capacity]);
	printf("Size now:  %d\n", [list length]);
	[list free];
	[list init];
	fillList(list);
	[list remove: @"hello"];
	[list remove: @"good day"];
	[list removeAll: @"good afternoon"];
	[list removeAll: @"good night"];
	printList(list);
	fillList(list);
	[list removeAll: @"hola"];
	[list removeAll: @"buenos dias"];
	[list remove: @"buenas tardes"];
	[list remove: @"buenas noches"];
	printList(list);
	[list delete];

	return 0;
}

void fillList(ArrayedList* list)
{
	[list clear];
	[list add: @"hello"];
	[list add: @"hola"];
	[list add: @"good day"];
	[list add: @"buenos dias"];
	[list add: @"good afternoon"];
	[list add: @"buenas tardes"];
	[list add: @"good night"];
	[list add: @"buenas noches"];
}

void printList(ArrayedList* list)
{
	int i, size = [list length];
	char* temp;
	for(i = 0; i < size; i++)
	{
		temp = [[list at: i] asCString];
		printf("%s\n", temp);
		free(temp);
	}
}
