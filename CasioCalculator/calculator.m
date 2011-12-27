//
//  calculator.m
//  calculator
//
//  Created by Steven Rygaard on 9/19/11.
//  Copyright 2011 Steven Rygaard. All rights reserved.
//

#import "calculator.h" 

@implementation calculator

/**
	Initlize the calculator
*/
-(id) init
{
    [super init];
    return self;
}

/**
	setOperation is the setter where the operation id is passed in
*/
- (void) setOperation: (int) o
{
    operationPressed = o;
}

/**
	setNumber is the setter where the number entered is passed in
		it is updated every time an int is appended
*/
- (void) setNumber: (double) n
{
    numberPressed = n;

}
/**
	setScreenNumber is the setter for the number on the screen when
 		an operator is pressed
*/
- (void) setScreenNumber: (double) s
{
    screenNumber = s;
}

/**
	performMath is a massive switch statement that performs the respective
		math when an operation button id is passed in
*/
- (void) performMath
{
    switch (operationPressed) {
        case 1: // Addition is specified
            resultMath = screenNumber + numberPressed;

            break;
        case 2: // Subtraction is specified
            resultMath = screenNumber - numberPressed;
            break;
        case 3: // Multiply is specified
            resultMath = screenNumber * numberPressed;
            break;
        case 4: // Divide is specified
            resultMath = screenNumber / numberPressed;
            break;
        case 5: // invert is specified
            resultMath = screenNumber * (-1);
            break;
        case 6: // Clear is specified
            resultMath = 0.0;
            numberPressed = 0.0;
            screenNumber = 0.0;
            break;
        case 7: // MemoryClear is specified
            memory = 0.0;
            break;
        case 8: // MemoryAdd is specified
            memory = memory + screenNumber;
            break;
        case 9: // MemorySubtract is specified
            memory = memory - screenNumber;
            break;
        case 10: // MemoryRecal is specified
            memory = memory;
            break;    
        case 11: // Decimal is specified
            memory = memory;
            break; 
        case 14: // Pi is specified
            resultMath = 3.1415926535897932384626433832795028841971693;
            break;
        case 15: // Sin is specified
            resultMath = 1/(screenNumber);
            break; 
        case 16: // Cos is specified
            resultMath = cos(screenNumber);
            break; 
        case 17: // Tan is specified
            resultMath = tan(screenNumber);
            break; 
        case 18: // Sqrt is specified
            resultMath = sqrt(screenNumber);
            break; 
    }
}

/**
	returnAnswer is a simple getter for the result of math operations 
		provided by performMath
*/
- (double) returnAnswer
{
    return resultMath;
}

// returnMem is a simple getter for the result of memory operation 
//		provided by performMath
- (double) returnMem
{
    return memory;
}

@end;
