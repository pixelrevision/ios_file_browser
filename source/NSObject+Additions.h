
#import <Foundation/Foundation.h>

@interface NSObject (Additions)

- (void) ifRespondsPerformSelector:(SEL) selector;
- (void) ifRespondsPerformSelector:(SEL) selector withObject:(id) arg1;

@end
