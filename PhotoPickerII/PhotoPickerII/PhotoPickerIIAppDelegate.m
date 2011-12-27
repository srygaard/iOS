//
//  PhotoPickerIIAppDelegate.m
//  PhotoPickerII
//
//  Created by MLIB116M66 on 10/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PhotoPickerIIAppDelegate.h"
#import "CategoriesViewController.h"

@implementation PhotoPickerIIAppDelegate


@synthesize window=_window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

  
    UINavigationController *navigationController = [[UINavigationController alloc] init];
    CategoriesViewController *categoriesController = [[CategoriesViewController alloc] init];
    
    [navigationController pushViewController:categoriesController animated:NO];
    
    self.window.rootViewController = navigationController;
    
    [navigationController release];
    [categoriesController release];
    
    [self.window makeKeyAndVisible];
        
    return YES;
}

@end
