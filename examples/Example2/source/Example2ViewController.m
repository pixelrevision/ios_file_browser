
#import "Example2ViewController.h"

@implementation Example2ViewController

- (void) viewDidLoad {
	browser = [[PXRFileBrowser alloc] initWithNibName:@"PXRFileBrowser" bundle:nil];
	[[self view] addSubview:[browser view]];
}

- (void) dealloc {
	[super dealloc];
}

@end
