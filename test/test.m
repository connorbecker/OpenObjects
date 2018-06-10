#import <stdio.h>
#import <openobjects/LinkedList.h>
#import <openobjects/String.h>

void fillList(LinkedList* list)
{
	String* one = [String newFromCString: "one"];
	String* two = [String newFromCString: "two"];
	String* three = [String newFromCString: "heya!"];

	[list add: one];
	[list add: two];
	[list add: three];
	[list add: one];
	[list add: two];
	[list add: one];
	//{"one", "two", "heya", "one", "two"}
}

void printList(LinkedList* list)
{
	int i;
	char* temp;
	for(i = 0; i < [list length]; i = i + 1)
	{
		temp = [[list at: i] asCString];
		printf("%s\n", [[list at: i] asCString]); //memory leak
		free(temp);
	}
}

int main(int argc, char* argv[])
{
	LinkedList* list = [LinkedList new];
	printf(">Initial Fill\n");
	fillList(list);
	//printf(">Remove item at: 3\n");
	//[list removeAt: 3];
	printf(">Print List\n");
	printList(list);
	String* temp = [String newFromCString: "one"];
	printf(">Remove items\n");
	//[list removeAll: temp];
	[list clear];
	[temp delete];
	printf(">Print List\n");
	printList(list);
	printf("%d\n", [list length]);
}

