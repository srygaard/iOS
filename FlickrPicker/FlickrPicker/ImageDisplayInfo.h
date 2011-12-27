//
//  ImageDisplayInfo.h
//  FlickrPicker
//
//  Created by MLIB116M65 on 10/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ImageDisplayInfo : NSObject {
    NSURL* URL;
    NSString* imageTag;
    NSURL*    hyperlink;
}

+ (ImageDisplayInfo *)  sharedSingleton;

- (void) setURL:(NSURL*)url;
- (NSURL*) getURL;

- (void) setImageTag:(NSString*)tag;
- (NSString*) getImageTag;
@end
