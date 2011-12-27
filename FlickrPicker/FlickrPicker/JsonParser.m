//
//  JsonParser.m
//  FlickrPicker
//
//  Created by MLIB116M65 on 10/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "JsonParser.h"


@implementation JsonParser

static JsonParser *sharedJsonParser = nil;

- (id)init{
    if (self == [super init])
    {
        FlickrAPIKey = @"0cb9cbf18d4e83de934470fc6a1df540";
        photoTitles = [[NSMutableArray alloc] init];
        photoSmallImageData = [[NSMutableArray alloc] init];
        photoURLsLargeImage = [[NSMutableArray alloc] init];
        imageDisplayInfo = [ImageDisplayInfo sharedSingleton];
    }
    return self;
}


// Super cool A+ singleton bro guy!
+ (JsonParser *) sharedSingleton{
    
	// Only allow to run in one thread at a time
    @synchronized(sharedJsonParser){
        if ( !sharedJsonParser || sharedJsonParser == nil){
            sharedJsonParser = [[JsonParser alloc] init];
        }
    }
    
    return sharedJsonParser;
}



- (void) searchFlickr:(NSString*)searchTerm{
    // Build the string to call the Flickr API

    NSString *urlString = 
        [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&tags=%@&per_page=%hu&format=json&nojsoncallback=1", 
        FlickrAPIKey, 
         searchTerm,
         10];
    
    // Create NSURL string from formatted string
    NSURL *url = [NSURL URLWithString:urlString];
    
    // Setup and start async download
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL: url];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection release];
    [request release];

}

- (NSString*) flickrPhotoTitle:(NSInteger)row{
    NSLog(@"titles: %@", photoTitles);
    return [photoTitles objectAtIndex:row];
}


- (NSArray*) getTitleArray{
    return photoTitles;
}

- (void) setActivePhotoArrayPos:(NSInteger)row{
    activePhotoArrayPos = row;
}

- (NSURL *) getActivePhotoURL{
    return [photoURLsLargeImage objectAtIndex:activePhotoArrayPos];
}

- (NSString *) getActiveTag{
    return [photoTitles objectAtIndex:activePhotoArrayPos];
}

- (void) addToTitleAray:(NSString *)key{
    [photoTitles addObject:(key.length > 0 ? key : @"Untitled")];
}

- (NSURL*) getTinyImageURL:(NSUInteger)row{
    smallImageURL = [photoSmallImageData objectAtIndex:row];
    return smallImageURL;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data 
{
    // Store incoming data into a string
    jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    // Create a dictionary from the JSON string
    results = [jsonString JSONValue];
    
    // Build an array from the dictionary for easy access to each entry
    NSArray *photos = [[results objectForKey:@"photos"] objectForKey:@"photo"];
    
    // Loop through the dictionary
    for (NSDictionary *photo in photos)
    {
        // Get title of the image
        NSString *title = [photo objectForKey:@"title"];
        
        // Save the title to the photo titles array
        [self addToTitleAray:title];
        
        NSString *photoURLString = 
        [NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@_s.jpg", 
         [photo objectForKey:@"farm"], [photo objectForKey:@"server"], 
         [photo objectForKey:@"id"], [photo objectForKey:@"secret"]];
        [photoSmallImageData addObject:[NSURL URLWithString:photoURLString]];
        

        photoURLString = 
        [NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@_m.jpg", 
         [photo objectForKey:@"farm"], [photo objectForKey:@"server"], 
         [photo objectForKey:@"id"], [photo objectForKey:@"secret"]];
        [photoURLsLargeImage addObject:[NSURL URLWithString:photoURLString]]; 
    } 
    
    // Reload the tableview for every add
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadRootViewControllerTable" object:nil];
}

- (void)dealloc{
    [photoTitles release];
    [photoSmallImageData release];
    [photoURLsLargeImage release];
    [super dealloc];
}

@end
