#import "UISlideButton.h"


@implementation UISlideButton
@synthesize delegate;
@synthesize threshhold;


- (void) touchesBegan:(NSSet *) touches withEvent:(UIEvent *) event {
	UITouch * touch = [touches anyObject];
	if([touches count] > 1) {
		[super touchesBegan:touches withEvent:event];
		return;
	}
	CGPoint loc = [touch locationInView:self];
	lastX = loc.x;
	[super touchesBegan:touches withEvent:event];
}

- (void) touchesEnded:(NSSet *) touches withEvent:(UIEvent *) event {
	UITouch * touch = [touches anyObject];
	if([touches count] > 1) {
		[super touchesEnded:touches withEvent:event];
		return;
	}
	CGPoint loc = [touch locationInView:self];
	if(lastX > loc.x && fabs(loc.x-lastX) > threshhold){
		[delegate slideButtonDidSlide:self];
		return;
	}
	[super touchesEnded:touches withEvent:event];
}

- (void)dealloc{
	self.delegate = nil;
	[super dealloc];
}

@end
