//
//  ImageDisplayInfo.m
//  FlickrPicker
//
//  Created by MLIB116M65 on 10/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ImageDisplayInfo.h"


@implementation ImageDisplayInfo

static ImageDisplayInfo *sharedSingleton = nil;

- (id)init{
    if (self == [super init])
    {

    }
    return self;
}


// Super cool A+ singleton bro guy!
+ (ImageDisplayInfo *) sharedSingleton{
    
	// Only allow to run in one thread at a time
    @synchronized(sharedSingleton){
        if ( !sharedSingleton || sharedSingleton == nil){
            sharedSingleton = [[ImageDisplayInfo alloc] init];
        }
    }
    
    return sharedSingleton;
}

- (void) setURL:(NSURL*)url{
    URL = url;
}
- (NSURL*) getURL{
    return URL;
}

- (void) setImageTag:(NSString*)tag{
    imageTag = tag;
}

- (NSString*) getImageTag{
    return imageTag;
}

- (void) dealloc{
    [hyperlink release];
    [super dealloc];
}

@end
