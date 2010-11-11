//
//  IphoneExampleAppDelegate.h
//  IphoneExample
//
//  Created by Malcolm Wilson on 11/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IphoneExampleViewController;

@interface IphoneExampleAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    IphoneExampleViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet IphoneExampleViewController *viewController;

@end

