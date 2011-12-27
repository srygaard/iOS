//
//  FlickrSearchResults.h
//  FlickrPicker
//
//  Created by MLIB116M65 on 10/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JsonParser.h"
#import "SearchTerms.h"
#import "ImageDisplayViewController.h"


@interface FlickrSearchResultsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    JsonParser *jsonParser;
    JsonParser *jsonParserSingleton;
    SearchTerms *searchTerms;
    ImageDisplayInfo *imageDisplayInfo;
    IBOutlet UITableView *tableView;
}

- (void) reloadTableViewData;
@end
