#import "PXRFileBrowserTableData.h"


@implementation PXRFileBrowserTableData
@synthesize delegate;

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*) indexPath {
	id cell = nil;
	PXRFileBrowserItem *d = [self itemInSection:0 atIndex:[indexPath row]];
	if(!d) return nil;
	PXRFileBrowserTableCell *c = (PXRFileBrowserTableCell*)[tableView dequeueReusableCellWithIdentifier:@"PXRFileBrowserTableCell"];
	if(!c) {
		loader = [[UITableCellLoader alloc] initWithNibName:@"PXRFileBrowserTableCell"];
		[loader load];
		c = [(UITableCellLoader *)[loader nibbedCell] retain];
		[loader release];
		[c autorelease];
	}
	[c reset];
	[c addData:d];
	cell = c;
	return cell;
}

- (BOOL)tableView:(UITableView*)tableView canEditRowAtIndexPath:(NSIndexPath*)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
	editingStyle = UITableViewCellEditingStyleDelete;
	PXRFileBrowserTableCell *tableCell = (PXRFileBrowserTableCell*)[tableView cellForRowAtIndexPath:indexPath];
	[delegate userWantsToRemoveFileAtPath:tableCell.filePath];
}

- (void)dealloc {
	self.delegate = nil;
    [super dealloc];
}

@end
