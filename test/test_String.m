#import <openobjects/String.h>
#include <stdio.h>

void printBOOL(BOOL yesNo);

int main(int argc, char* argv[])
{
	id testString = @"hello, world!";
	id tempString1;
	char* temp;
	char c;


	/* Test: asCString */
	temp = [testString asCString];
	printf("%s\n", temp);
	free(temp);

	/* Test: at */
	c = [testString at: 7];
	printf("%c\n", c);

	/* Test: from:to: */
	tempString1 = [testString from: 7 To: 11];
	temp = [tempString1 asCString];
	printf("%s\n", temp);
	free(temp);
	[tempString1 delete];

	/* Test: from:For: */
	tempString1 = [testString from: 0 For: 4];
	temp = [tempString1 asCString];
	printf("%s\n", temp);
	free(temp);
	[tempString1 delete];

	/* Test: find: */
	int pos = [testString find: @"world"];
	printf("1st pos: %d\n", pos);
	pos = [testString find: @"dl"];
	printf("2nd pos: %d\n", pos);

	/* Test: find:After: */
	pos = [testString find: @"hello" After: 1];
	printf("1st pos: %d\n", pos);
	pos = [testString find: @"heya" After: 0];
	printf("2nd pos: %d\n", pos);
	pos = [testString find: @"world" After: 3];
	printf("3rd pos: %d\n", pos);

	/* Test: isEqualTo: */
	printBOOL([testString isEqualTo: @"hello, world!"]);
	tempString1 = [String newFromCString: "HELLO, WORLD!"];
	printBOOL([tempString1 isEqualTo: testString]);
	[tempString1 delete];

	/* Test: isEmpty */
	printBOOL([testString isEmpty]);
	printBOOL([@"" isEmpty]);

	/* Test: asUppercase */
	tempString1 = [testString asUppercase];
	temp = [tempString1 asCString];
	printf("%s\n", temp);
	free(temp);
	[tempString1 delete];

	/* Test: asLowercase */
	tempString1 = [@"HEYA, WORLD!" asLowercase];
	temp = [tempString1 asCString];
	printf("%s\n", temp);
	free(temp);
	[tempString1 delete];

	return 0;
}

void printBOOL(BOOL yesNo)
{
	if(yesNo == YES)
	{
		printf("YES\n");
	}
	else
	{
		printf("NO\n");
	}
	return;
}
