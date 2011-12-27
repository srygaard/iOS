//
//  ComboManager.h
//  LockBox
//
//  Created by MLIB116M65 on 12/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ComboManager : NSObject {
    int codeNumber1;
    int codeNumber2;
    int codeNumber3;
    
    
    NSString        *pList;
    NSString        *bundleList;

    NSMutableDictionary    *combination;              // Dictionary of search terms

}
+ (ComboManager *) sharedSingleton;
- (void) setComboNumber:(int) number: (int)combo;
- (int)  getComboNumber:(int) number;
- (void) savePlist;

@end
