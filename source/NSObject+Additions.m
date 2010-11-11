
#import "NSObject+Additions.h"

@implementation NSObject (Additions)

- (void) ifRespondsPerformSelector:(SEL) selector {
	if([self respondsToSelector:selector]) [self performSelector:selector];
}

- (void) ifRespondsPerformSelector:(SEL) selector withObject:(id) arg1 {
	if([self respondsToSelector:selector]) [self performSelector:selector withObject:arg1];
}

@end
