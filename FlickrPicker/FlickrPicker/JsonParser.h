//
//  JsonParser.h
//  FlickrPicker
//
//  Created by MLIB116M65 on 10/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBJSON.h"
#import "ImageDisplayInfo.h"


@interface JsonParser : NSObject {
    ImageDisplayInfo *imageDisplayInfo;
    NSMutableArray  *photoTitles;         // Titles of images
    NSMutableArray  *photoSmallImageData; // Image data (thumbnail)
    NSMutableArray  *photoURLsLargeImage; // URL to larger image
    NSString        *FlickrAPIKey;
    
    NSDictionary    *results;               // Results from query
    NSString        *jsonString;
    BOOL            searchComplete;
    NSInteger       activePhotoArrayPos;
    NSString        *URLofActivePhoto;
    
    NSURL           *smallImageURL;


}
+ (JsonParser *)    sharedSingleton;
- (void)            searchFlickr:(NSString*)searchTerm;
- (NSString*)       flickrPhotoTitle:(NSInteger)row;
- (void)            connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;

- (void)            setActivePhotoArrayPos:(NSInteger)row;
- (NSURL *)         getActivePhotoURL;
- (NSString *)      getActiveTag;

- (void)            addToTitleAray:(NSString*)key;
- (NSArray*)        getTitleArray;
- (NSURL*)          getTinyImageURL:(NSUInteger)row;

@end
