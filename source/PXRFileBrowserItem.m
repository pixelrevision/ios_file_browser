#import "PXRFileBrowserItem.h"


@implementation PXRFileBrowserItem
@synthesize fileTitle;
@synthesize isDirectory;
@synthesize path;
@synthesize isSelectable;

+ (PXRFileBrowserItem*)itemWithTitle:(NSString *)t andPath:(NSString *)p isDirectory:(BOOL)isDir{
	PXRFileBrowserItem *d = [[PXRFileBrowserItem alloc] init];
	d.fileTitle = t;
	d.path = p;
	d.isDirectory = isDir;
	d.isSelectable = true;
	return [d autorelease];
}

- (void)dealloc{
	self.fileTitle = nil;
	self.path = nil;
	[super dealloc];
}

@end
