#import <Foundation/Foundation.h>
#import "UITableDataSourceController.h"
#import "PXRFileBrowserItem.h"
#import "PXRFileBrowserTableCell.h"
#import "UITableCellLoader.h"

@class PXRFileBrowserTableData;

@protocol PXRFileBrowserTableDataDelegate
- (void)userWantsToRemoveFileAtPath:(NSString*)path;
@end


@interface PXRFileBrowserTableData : UITableDataSourceController{
	UITableCellLoader * loader;
	NSObject <PXRFileBrowserTableDataDelegate> *delegate;
}
@property (nonatomic, assign) id delegate;

@end
