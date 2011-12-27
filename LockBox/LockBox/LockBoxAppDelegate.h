//
//  LockBoxAppDelegate.h
//  LockBox
//
//  Created by MLIB116M65 on 12/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#include "TargetConditionals.h"


@class LockBoxViewController;

@interface LockBoxAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet LockBoxViewController *viewController;

@end
