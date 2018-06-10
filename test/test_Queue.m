#import <openobjects/Queue.h>
#include <stdio.h>

@interface Customer : Base
{
	int place;
}
-(id) setPlace: (int)newVal;
-(int) getPlace;
@end
@implementation Customer
-(id) setPlace: (int)newVal
{
	place = newVal;
	return self;
}
-(int) getPlace
{
	return place;
}
@end

int main(int argc, char* argv[])
{
	id customers = [Queue new];
	id temp;
	int counter = 0;
	
	while(counter < 10)
	{
		counter = counter + 1;
		[customers push: [[Customer new] setPlace: counter]];
	}

	temp = [customers pull];
	while([temp getPlace] < 100)
	{
		printf("%d\n", [temp getPlace]);
		counter = counter + 1;
		[temp delete];
		[customers push: [[Customer new] setPlace: counter]];
		temp = [customers pull];
	}

	printf("%d\n", [customers size]);
	[customers erase];
	printf("%d\n", [customers size]);

	return 0;
}
