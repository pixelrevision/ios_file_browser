
#import "UITableDataSourceController.h"

@implementation UITableDataSourceController
@synthesize data;

- (id) init {
	if(!(self = [super init])) return nil;
	data = [[NSMutableArray alloc] init];
	return self;
}

- (void) addSection {
	NSMutableArray * a = [[NSMutableArray alloc] init];
	[data addObject:a];
	[a release];
}

- (NSMutableArray *) dataInSection:(NSInteger) section {
	if([data count] < section) return nil;
	return [data objectAtIndex:section];
}

- (void) addItem:(id) item toSection:(NSInteger) section {
	if([data count] < section || !data) return;
	[[data objectAtIndex:section] addObject:item];
}

- (void) removeLastItemInSection:(NSInteger) section {
	if([data count] < section || !data) return;
	[[data objectAtIndex:section] removeLastObject];
}

- (void) removeAllItemsInSection:(NSInteger) section {
	if([data count] < section || !data) return;
	[[data objectAtIndex:section] removeAllObjects];
}

- (NSUInteger) countOfItemsInSection:(NSInteger) section {
	if([data count] < section) return 0;
	return [[data objectAtIndex:section] count];
}

- (void) removeItemInSection:(NSInteger) section atIndex:(NSInteger) index {
	if([data count] < section) return;
	if([[data objectAtIndex:section] count] < index) return;
	[[data objectAtIndex:section] removeObjectAtIndex:index];
}

- (id) itemInSection:(NSInteger) section atIndex:(NSInteger) index {
	if([data count] < section) return nil;
	if([[data objectAtIndex:section] count] < index) return nil;
	return [[data objectAtIndex:section] objectAtIndex:index];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *) tableView {
	if(!data) return 0;
	return [data count];
}

- (NSInteger) tableView:(UITableView *) table numberOfRowsInSection:(NSInteger) section {
	if(!data) return 0;
	if([data count] < section) return 0;
	return [[data objectAtIndex:section] count];
}

- (UITableViewCell *) tableView:(UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *) indexPath {
	NSLog(@"ERROR: You need to implement tableView:cellForRowAtIndexPath: in your UITableDataSourceController subclass.");
	return nil;
}

- (void) dealloc {
	#ifdef ACNSLogDealloc
	NSLog(@"DEALLOC UITableDataSourceController");
	#endif
	[data release];
	data = nil;
	[super dealloc];
}

@end
