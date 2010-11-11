
#import "UIView+Additions.h"

@implementation UIView (Additions)

- (BOOL) findAndResignFirstResonder {
	if(self.isFirstResponder) {
		[self resignFirstResponder];
		return YES;    
    }
	for(UIView * subView in self.subviews) {
		if ([subView findAndResignFirstResonder]) return YES;
    }
	return NO;
}

- (void) removeAllSubviews {
	UIView * view;
	NSArray * subviews = [self subviews];
	int i = [subviews count];
	for(;i > 0;--i) {
		view = [subviews objectAtIndex:(i-1)];
		[view removeFromSuperview];
	}
}

@end
