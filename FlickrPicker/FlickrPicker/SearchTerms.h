//
//  SearchTerms.h
//  FlickrPicker
//
//  Created by MLIB116M65 on 10/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SearchTerms : NSObject {
    NSString        *activeSearchTerm;
    NSString        *p;
    NSDictionary    *searchTerms;              // Dictionary of search terms
    NSMutableArray  *searchTermsValueArray;
    
}
+ (SearchTerms *) sharedSearchTerms;

- (NSInteger) sizeOfSearchList;
- (NSString *) searchNameAtRow:(NSInteger)row;
- (void) setSearchTerm:(NSInteger)row;
- (NSString*) getSeachTerm;


@end
