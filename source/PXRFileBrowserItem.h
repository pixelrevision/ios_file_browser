#import <Foundation/Foundation.h>
#import "UITableDataSourceController.h"

@interface PXRFileBrowserItem : UITableDataSourceController{
	BOOL isDirectory;
	NSString *fileTitle;
	NSString *path;
	BOOL isSelectable;
}

@property (nonatomic, assign) BOOL isDirectory;
@property (nonatomic, retain) NSString *fileTitle;
@property (nonatomic, retain) NSString *path;
@property (nonatomic, assign) BOOL isSelectable;

+ (PXRFileBrowserItem*)itemWithTitle:(NSString *)t andPath:(NSString *)p isDirectory:(BOOL)isDir;

@end
