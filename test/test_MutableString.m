#import <openobjects/MutableString.h>
#include <stdio.h>

int main(int argc, char* argv[])
{
	id testString = [MutableString newFromCString: "Hello, World!"];
	char* temp;

	/* Test: add: */
	temp = [testString asCString];
	printf("%s\n", temp);
	free(temp);
	[testString add: testString];
	temp = [testString asCString];
	printf("%s\n", temp);
	free(temp);

	/* Test: addCString: */
	[testString addCString: "Hello, World!"];
	[testString addCString: ""];
	temp = [testString asCString];
	printf("%s\n", temp);
	free(temp);

	/* Test: toUppercase */
	[testString toUppercase];
	temp = [testString asCString];
	printf("%s\n", temp);
	free(temp);

	/* Test: toLowercase */
	[testString toLowercase];
	temp = [testString asCString];
	printf("%s\n", temp);
	free(temp);

	return 0;
}
