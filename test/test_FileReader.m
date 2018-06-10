#import <OpenObjects.h>
#include <stdio.h>

int main(int argc, char* argv[])
{
	FileReader* fr = [FileReader newFromString: @"filereaderTest.m"];
	String* tempString;
	char* tempCString;
	int i;

	while(![fr isFinished])
	{
		printf("%c", [fr readChar]);
	}

	[fr restart];
	while(![fr isFinished])
	{
		tempString = [fr readLine];
		tempCString = [tempString asCString];
		printf("%s", tempCString);
		free(tempCString);
		[tempString delete];	
	}

	[fr restart];
	while(![fr isFinished])
	{
		tempCString = [fr readCLine];
		printf("%s", tempCString);
		free(tempCString);
	}

	[fr restart];
	while(![fr isFinished])
	{
		[fr nextLine];
		i = i + 1;
	}
	printf("There are %d lines in the file.\n", i);

	return 0;
}
