//
//  calculator.h
//  calculator
//
//  Created by Steven Rygaard on 9/19/11.
//  Copyright 2011 Steven Rygaard. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface calculator : NSObject{
    // Operation Variables
    int operationPressed;
    int prevOperationPressed;
    
    // |numberPressed| is not only set for every number 
	//		button pressed, but also is updated every 
	//		time the screen number is appeneded
    double numberPressed;
	
	// |screenNumber| is where the number on the the 
	//		screen is saved to
    double screenNumber;
    
    // Result Variables
    double resultMath;
	
	// |numberInProgress| a bool protect the appending to 
	//	the string of the number being entered
    bool numberInProgress;
    
    // Memory Variables used m+, m-, mr, mc
    double memory;
    
}
// 
- (void) setOperation: (int)buttonOperation; 
- (void) setNumber: (double)buttonNumber;
- (void) setScreenNumber: (double)screenNumber;
- (void) performMath;

// Prototypes for getters of memory and math answers
//		they need to be updated by a [ calculator perfromMath]
- (double) returnAnswer;
- (double) returnMem;

@end
