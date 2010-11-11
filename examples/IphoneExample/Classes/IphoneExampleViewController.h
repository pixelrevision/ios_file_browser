#import <UIKit/UIKit.h>
#import "PXRFileBrowser.h"

@interface IphoneExampleViewController : UIViewController <PXRFileBrowserDelegate, UITextViewDelegate>{
	IBOutlet UITextView *loadedText;
	IBOutlet UITextView *savedText;
	NSString *defaultText;
}

- (IBAction)saveText;
- (IBAction)loadText;

@end

