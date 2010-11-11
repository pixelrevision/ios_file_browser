#import <UIKit/UIKit.h>
#import "PXRFileBrowserItem.h"
#import "UISlideButton.h"

@interface PXRFileBrowserTableCell : UITableViewCell {
	UIImageView *icon;
	UILabel *fileLabel;
	NSString *filePath;
}

@property (nonatomic,retain) IBOutlet UIImageView *icon;
@property (nonatomic,retain) IBOutlet UILabel *fileLabel;
@property (nonatomic,retain) IBOutlet NSString *filePath;

- (void)addData:(PXRFileBrowserItem*)rowData;
- (void)reset;

@end
