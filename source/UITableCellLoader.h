
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NSObject+Additions.h"

@interface UITableCellLoader : NSObject {
	NSString * nibName;
	UITableViewCell * nibbedCell;
	UIView * view;
}

@property (nonatomic,retain) IBOutlet UIView * view;
@property (nonatomic,retain) IBOutlet UITableViewCell * nibbedCell;
@property (nonatomic,copy) NSString * nibName;

- (void) load;
- (id) initWithNibName:(NSString *) _nibName;

@end
