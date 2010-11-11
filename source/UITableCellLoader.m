
#import "UITableCellLoader.h"

@implementation UITableCellLoader
@synthesize nibName;
@synthesize nibbedCell;
@synthesize view;

- (id) initWithNibName:(NSString *) _nibName {
	if(!(self = [super init])) return nil;
	[self setNibName:_nibName];
	return self;
}

- (void) load {
	NSBundle * mb = [NSBundle mainBundle];
	[mb loadNibNamed:nibName owner:self options:nil];
	[nibbedCell ifRespondsPerformSelector:@selector(viewDidLoad)];
}

- (void) dealloc {
	[nibName release];
	[nibbedCell release];
	nibName = nil;
	nibbedCell = nil;
	[super dealloc];
}

@end
