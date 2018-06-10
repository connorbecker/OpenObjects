#import <openobjects/Stack.h>
#include <stdio.h>

typedef enum {ADD, SUBTRACT} Op;

@interface StackItem : Base{
	int val;
	Op op;
	BOOL isVal;
}
-(id) initVal: (int)newVal;
-(id) initOp: (Op)newOp;
+(id) newFromVal: (int)newVal;
+(id) newFromOp: (Op)newOp;
-(id) setVal: (int)newVal;
-(int) getVal;
-(id) setOp: (Op)newOp;
-(Op) getOp;
-(BOOL) isVal;
-(BOOL) isOp;
@end

@implementation StackItem
-(id) initVal: (int)newVal{
	if(self = [super init]){
		val = newVal;
		isVal = YES;
	}
	return self;
}
-(id) initOp: (Op)newOp{
	if(self = [super init]){
		op = newOp;
		isVal = NO;
	}
}
+(id) newFromVal: (int)newVal{ return [[self alloc] initVal: newVal]; }
+(id) newFromOp: (Op)newOp{ return [[self alloc] initOp: newOp]; }
-(id) setVal: (int)newVal{
	val = newVal;
	isVal = YES;
}
-(int) getVal{ return val; }
-(id) setOp: (Op)newOp{
	op = newOp;
	isVal = NO;
}
-(Op) getOp;{ return op; }
-(BOOL) isVal{ return isVal; }
-(BOOL) isOp{ return !isVal; }
@end

int main(int argc, char* argv[])
{
	id calc = [Stack new];
	id item, temp1, temp2;
	int total, subtotal;

	//Fill stack...
	[calc push: [StackItem newFromVal: 5]];
	[calc push: [StackItem newFromVal: 10]];
	[calc push: [StackItem newFromOp: ADD]];
	[calc push: [StackItem newFromVal: 40]];
	[calc push: [StackItem newFromVal: 25]];
	[calc push: [StackItem newFromOp: SUBTRACT]];

	//run calculator
	while([calc size] > 0)
	{
		item = [calc pop];
		if([item isVal])
			break;	//crash!!!
		temp1 = [calc pop];
		if(![temp1 isVal])
			break;	//crash!!!
		temp2 = [calc pop];
		if(![temp2 isVal])
			break;	//crash!!!
		switch([item getOp])
		{
			case ADD:
				subtotal = [temp1 getVal] + [temp2 getVal];
				total = total + subtotal;
				printf("%d\n", subtotal);
				break;
			case SUBTRACT:
				subtotal = [temp1 getVal] - [temp2 getVal];
				total = total + subtotal;
				printf("%d\n", subtotal);
				break;
			//default:
				//crash!!!
		}
		[item delete];
		[temp1 delete];
		[temp2 delete];
	}
	printf("-----\n");
	printf("%d\n", total);

	[calc push: [StackItem newFromVal: 20]];
	[calc push: [StackItem newFromVal: 25]];
	temp1 = [calc peek];
	printf("peeked value:       %d\n", [temp1 getVal]);
	[calc push: [StackItem newFromOp: ADD]];
	printf("size before erase:  %d\n", [calc size]);
	[calc erase];
	printf("size after erase:   %d\n", [calc size]);

	return;
}
