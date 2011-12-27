//
//  calculatorAppDelegate.h
//  calculator
//
//  Created by MLIB116M65 on 9/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class calculatorViewController;

@interface calculatorAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet calculatorViewController *viewController;

@end
