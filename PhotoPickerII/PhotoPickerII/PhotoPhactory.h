//
//  PhotoPhactory.h
//  PhotoPicker
//
//  Created by MLIB116M66 on 10/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PhotoPhactory : NSObject {
    NSString *p;
    NSDictionary *photoList;
    
    NSInteger activeCategoryArrayPos;
    NSInteger activePhotoArrayPos;
    
    NSArray *photoListKeyArray;
    NSMutableArray *photoListValueArray;
    
    NSArray *sortedPhotoListKeyArray;
    
    float alpha;
    
}

+ (PhotoPhactory *) sharedSingleton;


- (NSInteger) photoCategoryCount;
- (NSInteger) photosInActiveCatagory;
- (NSString *) catagoryNameAtIndex:(NSInteger)index;
- (NSString *) photoNameAtIndex:(NSInteger)index;

- (void) setActiveCatagory:(NSInteger)index;
- (void) setActivePhoto:(NSInteger)index;

- (NSArray *) getActivePhotoArray;
- (NSArray *) getActiveFileArray;
- (NSString *) getActiveCategoryName;

- (NSString *) activePhotoFileName;

- (void) setAlpha:(float)alpha;
- (float) getAlpha;


@end
