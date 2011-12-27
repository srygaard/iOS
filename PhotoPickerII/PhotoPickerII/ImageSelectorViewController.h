//
//  CategoriesViewController.h
//  PhotoPickerII
//
//  Created by MLIB116M66 on 10/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoPhactory.h"
#import "ImageDisplayViewController.h"

@interface ImageSelectorViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    PhotoPhactory *photoPhactory;
}

@end
