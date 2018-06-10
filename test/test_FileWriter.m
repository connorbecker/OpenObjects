#import <OpenObjects.h>
#include <stdio.h>

int main(int argc, char* argv[])
{
	FileWriter* fw = [FileWriter newFromString: @"hey_a_new_file.txt"];

	[fw writeChar: 'a'];
	[fw writeChar: '\n'];
	[fw write: @"-write:"];
	[fw cr];
	[fw writeC: "-writeC:"];
	[fw cr];
	[fw writeLine: @"-writeLine:"];
	[fw writeCLine: "-writeCLine:"];

	return 0;
}
