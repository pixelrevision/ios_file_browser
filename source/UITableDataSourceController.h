
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UITableDataSourceController : NSObject <UITableViewDataSource> {
	NSMutableArray * data;
}

@property (nonatomic,retain) NSMutableArray * data;

- (void) addSection;
- (void) removeAllItemsInSection:(NSInteger) section;
- (void) removeLastItemInSection:(NSInteger) section;
- (void) removeItemInSection:(NSInteger) section atIndex:(NSInteger) index;
- (void) addItem:(id) item toSection:(NSInteger) section;
- (id) itemInSection:(NSInteger) section atIndex:(NSInteger) index;
- (NSMutableArray *) dataInSection:(NSInteger) section;
- (NSUInteger) countOfItemsInSection:(NSInteger) section;

@end
