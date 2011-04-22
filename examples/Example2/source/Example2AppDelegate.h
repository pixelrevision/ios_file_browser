//
//  Example2AppDelegate.h
//  Example2
//
//  Created by Aaron Smith on 4/22/11.
//  Copyright 2011 Videoegg. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Example2ViewController;

@interface Example2AppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    Example2ViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet Example2ViewController *viewController;

@end

