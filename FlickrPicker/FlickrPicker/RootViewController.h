//
//  RootViewController.h
//  FlickrPicker
//
//  Created by MLIB116M65 on 10/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlickrSearchResultsViewController.h"
#import "FlickrPickerAppDelegate.h"
#import "SearchTerms.h"

@interface RootViewController : UITableViewController {
    SearchTerms *searchTerms;
}


@end
