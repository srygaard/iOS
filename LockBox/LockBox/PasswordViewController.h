//
//  PasswordViewController.h
//  LockBox
//
//  Created by MLIB116M65 on 12/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeychainItemWrapper.h"
#import "LockBoxAppDelegate.h"
#import "ComboManager.h"
#include "TargetConditionals.h"


@interface PasswordViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate> {
    ComboManager *myComboManager;

    KeychainItemWrapper *keychain;// = [[KeychainItemWrapper alloc] initWithIdentifier:@"TestAppLoginData" accessGroup:nil];
    IBOutlet UIPickerView *pickerView;
    IBOutlet UINavigationBar *navBar;
    UIActionSheet *actionSheet;
    IBOutlet UILabel *secretData;
    
}
-(IBAction)changeCombo:(id)sender;
-(void)goAwayActionSheet;
-(IBAction)lockDown:(id)sender;

@end
