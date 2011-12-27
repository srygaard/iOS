//
//  calculatorViewController.h
//  calculator
//
//  Created by Steven Rygaard on 9/19/11.
//  Copyright 2011 Steven Rygaard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "calculator.h"

@interface calculatorViewController : UIViewController {
   
   // Calculator clasas instance variable
    calculator *calc;
    
	// Define the IBOutlet of the display for the calculator
    IBOutlet UILabel *calcDisplay;
	
    int numberID;
    int operationID;
    double result;
    bool numberInProgress;
    bool decimalPlaced;
	double currentNumber;

}

@property (retain, nonatomic) calculator *calc;

- (IBAction) numberPressed:(id)sender;
- (IBAction) operatorPressed:(id)sender;
- (IBAction) findResult:(id)sender;

@end
