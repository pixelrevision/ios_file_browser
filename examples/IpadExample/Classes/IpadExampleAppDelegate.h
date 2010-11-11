//
//  IpadExampleAppDelegate.h
//  IpadExample
//
//  Created by Malcolm Wilson on 11/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IpadExampleViewController;

@interface IpadExampleAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    IpadExampleViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet IpadExampleViewController *viewController;

@end

