#import <UIKit/UIKit.h>

@class UISlideButton;

@protocol UISlideButtonDelegate
- (void)slideButtonDidSlide:(UISlideButton*)button;
@end


@interface UISlideButton : UIButton {
	NSObject <UISlideButtonDelegate> *delegate;
	float threshhold;
	float lastX;
	float lastY;
}
@property (nonatomic, assign) float threshhold;
@property (nonatomic, retain) id delegate;

@end
