//
//  LockBoxViewController.h
//  LockBox
//
//  Created by MLIB116M65 on 12/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PasswordViewController.h"
#import <AVFoundation/AVFoundation.h>
#include "TargetConditionals.h"
#include "ComboManager.h"
#include <CoreMotion/CoreMotion.h>


@interface LockBoxViewController : UIViewController <UIAccelerometerDelegate> {

    ComboManager *myComboManager;
    IBOutlet UIImageView *dial;
    IBOutlet UISlider *slider;
    IBOutlet UILabel *numberLabel;
    
    CGRect textRect;
    UIFont *textFont;
    
    int codeNumber1;
    int codeNumber2;
    int codeNumber3;

    int firstNumberEntered;
    int secondNumberEntered;
    int thirdNumberEntered;
    
    int numberInSequence;
    int activeDialNumber;
    int _activeDialNumber;
    AVAudioPlayer *audioPlayer;
    NSString *path;
    PasswordViewController *myPasswordViewController;
    
    CMMotionManager *motionManager;
    float previousX;
    float previousY;
    int dialAcc;
    int _dialAcc;
    
    CGPoint touch1;
    CGPoint touch2;
    CGPoint lastTouch1;
    CGPoint lastTouch2;
    
    IBOutlet UIImageView *lockLoop;
    IBOutlet UIPageControl *pageControl;
}

-(IBAction)tapDial:(id)sender;
-(IBAction)rotateDial;
-(IBAction)byPass:(id)sender;
-(void)animateNumber:(int)number;
-(void)animateWrong;
-(void)animationHasFinished:(NSString *)animationID finished:(BOOL)finished context:(void *)context;
-(void)animationWrongHasFinished:(NSString *)animationID finished:(BOOL)finished context:(void *)context;

@property(nonatomic, retain) IBOutlet UIImageView *dial;
@property(nonatomic, retain) IBOutlet UILabel *numberLabel;
@property(nonatomic, retain) UIPageControl *pageControl;


@end
