//
//  ComboManager.m
//  LockBox
//
//  Created by MLIB116M65 on 12/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ComboManager.h"


@implementation ComboManager

static ComboManager *sharedComboManager = nil;

- (id)init{
    if (self == [super init])
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES); 
        NSString *documentsPath = [paths objectAtIndex:0]; 
        
        pList =  [documentsPath stringByAppendingPathComponent:@"combination.plist"];
        [pList retain];

        NSFileManager *fileManager = [NSFileManager defaultManager];
              
        if(![fileManager fileExistsAtPath:pList])
        {
            bundleList = [[NSBundle mainBundle] pathForResource:@"combination" ofType:@"plist"];
            combination = [[NSMutableDictionary alloc] initWithContentsOfFile:bundleList];
            
            [combination writeToFile:pList atomically:YES];
            NSLog(@"Wrote a pList fromt the bundle to %@", pList);

        }

        combination = [[NSMutableDictionary alloc] initWithContentsOfFile:pList];
        codeNumber1=[[combination objectForKey:@"codeValue1"] intValue];
        codeNumber2=[[combination objectForKey:@"codeValue2"] intValue];
        codeNumber3=[[combination objectForKey:@"codeValue3"] intValue];
    }
    return self;
}

+ (ComboManager *) sharedSingleton{
    
	// Only allow to run in one thread at a time
    @synchronized(sharedComboManager){
        if ( !sharedComboManager || sharedComboManager == nil){
            sharedComboManager = [[ComboManager alloc] init];
        }
    }
    
    return sharedComboManager;
}

-(void) setComboNumber:(int)number : (int)combo{
    switch (number) {
        case 1:
            NSLog(@"Set 1= %i",combo);
            codeNumber1 = combo;
            break;
        case 2:
            NSLog(@"Set 2= %i",combo);
            codeNumber2 = combo;
            break;
        case 3:
            NSLog(@"Set 3= %i",combo);
            codeNumber3 = combo;
            break;
        default:
            break;
    } 
}

- (int) getComboNumber:(int)number
{
    switch (number) {
        case 1:
            NSLog(@"Get 1= %i",codeNumber1);
            return codeNumber1;
            break;
        case 2:
            NSLog(@"Get 2= %i",codeNumber2);
            return codeNumber2;
            break;
        case 3:
            NSLog(@"Get 3= %i",codeNumber3);
            return codeNumber3;
            break;
        default:
            return 0;
            break;
    } 
}

-(void)savePlist{
    
    [combination setValue:[NSNumber numberWithInt:codeNumber1] forKey:@"codeValue1"];
    [combination setValue:[NSNumber numberWithInt:codeNumber2] forKey:@"codeValue2"];
    [combination setValue:[NSNumber numberWithInt:codeNumber3] forKey:@"codeValue3"];
    [combination writeToFile:pList atomically:YES];
}

@end
