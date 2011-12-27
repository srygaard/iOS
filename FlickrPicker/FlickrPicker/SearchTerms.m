//
//  SearchTerms.m
//  FlickrPicker
//
//  Created by MLIB116M65 on 10/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SearchTerms.h"


@implementation SearchTerms

static SearchTerms *sharedSearchTerms = nil;

- (id)init{
    if (self == [super init])
    {
        // Build the dictionary of the search terms on init
        p = [[NSBundle mainBundle] pathForResource:@"searchTerms" ofType:@"plist"];
        searchTerms = [NSDictionary dictionaryWithContentsOfFile:p];
        
    }
    return self;
}


// Super cool A+ singleton bro guy!
+ (SearchTerms *) sharedSearchTerms{
    
	// Only allow to run in one thread at a time
    @synchronized(sharedSearchTerms){
        if ( !sharedSearchTerms || sharedSearchTerms == nil){
            sharedSearchTerms = [[SearchTerms alloc] init];
        }
    }
    
    return sharedSearchTerms;
}

-(NSInteger)sizeOfSearchList{
    searchTermsValueArray = [[[searchTerms allValues] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] retain];
    return [searchTermsValueArray count];
}

-(void)setSearchTerm:(NSInteger)row{
    activeSearchTerm = [searchTermsValueArray objectAtIndex:row];
}

-(NSString*)getSeachTerm{
    return activeSearchTerm;
}

-(NSString *)searchNameAtRow:(NSInteger)row{
    return [searchTermsValueArray objectAtIndex:row];
}

- (void)dealloc{
    [super dealloc];
}


@end
