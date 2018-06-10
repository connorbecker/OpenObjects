#import <OpenObjects.h>
#include <stdio.h>

int main(int argc, char* argv)
{
	
	Transcript* t = [Transcript new];
	[t writeLine: @"Hello World!"];
	[t readLine]; //free-then-init fails...
	

//	File* file = [File newFromStdIn];
//	FileReader* fr = [FileReader newFromFile: file];
//	printf("%s", [[fr readLine] asCString]);

	return 0;	
}
