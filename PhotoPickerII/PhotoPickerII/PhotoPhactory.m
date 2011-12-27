//
//  PhotoPhactory.m
//  PhotoPicker
//
//  Created by MLIB116M66 on 10/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PhotoPhactory.h"


@implementation PhotoPhactory

static PhotoPhactory *sharedPhotoPhactory = nil;

- (id)init
{
    if (self = [super init])
    {
        // Build the dictionary on init
        p = [[NSBundle mainBundle] pathForResource:@"photos" ofType:@"plist"];
        photoList = [NSDictionary dictionaryWithContentsOfFile:p];
        
        // Extract the Keys and Values from the dictionary; this is where we read all of our data
        //photoListKeyArray = [[[photoList allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] retain];
        photoListKeyArray = [[photoList allKeys] retain];
        //photoListValueArray = [[[photoList allValues] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] retain];
        photoListValueArray = [[photoList allValues] retain];
    }
    
    return self;
}


// Super cool A+ singleton bro guy!
+ (PhotoPhactory *) sharedSingleton{
    
	// Only allow to run in one thread at a time
    @synchronized(sharedPhotoPhactory){
        if ( !sharedPhotoPhactory || sharedPhotoPhactory == nil){
            sharedPhotoPhactory = [[PhotoPhactory alloc] init];
        }
    }
    
    return sharedPhotoPhactory;
}


// Methods to return the size requested for the catagory row count
///////////////////////////////////////////////////////////////////////////
- (NSInteger) photoCategoryCount
{
    return sizeof(photoListKeyArray)-1;
}

- (NSInteger) photosInActiveCatagory
{
    return  [[self getActivePhotoArray] count];
}


// Methods to return the string requested for the catagory row
///////////////////////////////////////////////////////////////////////////
- (NSString *) catagoryNameAtIndex:(NSInteger)index
{
    return [photoListKeyArray objectAtIndex:index];
}

- (NSString *) photoNameAtIndex:(NSInteger)index
{
    return [[self getActivePhotoArray] objectAtIndex:index];
}



// Setters to update the active category and photo idex positions
///////////////////////////////////////////////////////////////////////////
- (void) setActiveCatagory:(NSInteger)index
{
    activeCategoryArrayPos = index;
}

- (void) setActivePhoto:(NSInteger)index
{
    activePhotoArrayPos = index;
}


// Getters for the arrays of photos/names/categorys for selected items
///////////////////////////////////////////////////////////////////////////

// Return a sorted array with all of the photo names for the active category
- (NSArray *) getActivePhotoArray
{
    return     [[[photoListValueArray objectAtIndex:activeCategoryArrayPos] allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}

// Return a sorted array with all of the photo file names for the active category
- (NSArray *) getActiveFileArray
{
    
    return [[[photoListValueArray objectAtIndex:activeCategoryArrayPos] allValues] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}

- (NSString *) getActiveCategoryName
{
    return [self catagoryNameAtIndex:activeCategoryArrayPos];
}

// Return the selected photo's file name
- (NSString *) activePhotoFileName
{
    return [[self getActiveFileArray] objectAtIndex:activePhotoArrayPos];
}

// Getter and setter for slider alpha value
///////////////////////////////////////////////////////////////////////////
- (void) setAlpha:(float)value
{
    alpha = value;
}

- (float) getAlpha
{
    return alpha;
}

- (void)dealloc
{
    [sharedPhotoPhactory release];
    [photoListValueArray release];
    [photoListKeyArray release];
    [super dealloc];
}

@end
