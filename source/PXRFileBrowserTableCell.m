#import "PXRFileBrowserTableCell.h"


@implementation PXRFileBrowserTableCell
@synthesize icon;
@synthesize fileLabel;
@synthesize filePath;

- (void)addData:(PXRFileBrowserItem*)rowData{
	if(rowData.isDirectory){
		[self.icon setImage:[UIImage imageNamed:@"folder_icon.png"]];
	}else{
		[self.icon setImage:[UIImage imageNamed:@"doc_icon.png"]];
	}
	fileLabel.text = rowData.fileTitle;
	self.filePath = rowData.path;
	if(!rowData.isSelectable){
		fileLabel.alpha = .25;
		icon.alpha = .25;
	}else{
		fileLabel.alpha = 1;
		icon.alpha = 1;
	}
}



- (void)reset{
	[self.icon setImage:NULL];
	[self.fileLabel setText:@""];
}

- (void) dealloc {
	[self.icon setImage:NULL];
	[self.fileLabel setText:@""];
	self.filePath = nil;
	self.fileLabel = nil;
	self.icon = nil;
    [super dealloc];
}

@end
