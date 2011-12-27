//
//  LockBoxViewController.m
//  LockBox
//
//  Created by MLIB116M65 on 12/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import "LockBoxViewController.h"

@implementation LockBoxViewController
@synthesize dial;
@synthesize numberLabel;
@synthesize pageControl;


-(IBAction)rotateDial
{
    activeDialNumber = (int)(slider.value);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.1];
    dial.transform = CGAffineTransformMakeRotation(-activeDialNumber/(2*M_PI));  // 40/(2*pi) = 6.36619772
    [UIView commitAnimations];
    
    if (activeDialNumber != _activeDialNumber) {
        [audioPlayer play];
        _activeDialNumber = activeDialNumber;
    }
}

-(void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
    previousX = (acceleration.x * .15) + (previousX * (.85));
    previousY = (acceleration.y * .15) + (previousY * (.85));

    slider.value = (atan2(previousX, previousY) + M_PI)/40;
    dialAcc = 40-(atan2(previousX, previousY) + M_PI)*(20/M_PI);
    
    if (dialAcc != _dialAcc) {
            [audioPlayer play];
        slider.value = dialAcc;
        dial.transform = CGAffineTransformMakeRotation(-dialAcc*(2*M_PI/40)); 
        _dialAcc = dialAcc;
    }
}
/*
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

}

                               

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [super touchesMoved:touches withEvent:event];

 
    if ([[touches allObjects] count]) {

            touch1 = [[[touches allObjects] objectAtIndex:0] locationInView:self.view]; 
            touch2 = [[[touches allObjects] objectAtIndex:1] locationInView:self.view];
            
            CGFloat previousAngle = atan2(lastTouch2.y - lastTouch1.y, lastTouch2.x - lastTouch1.x) * 180 / M_PI;
            CGFloat currentAngle = atan2(touch2.y - touch1.y,touch2.x - touch2.x) * 180 / M_PI;
        NSLog(@"%f",currentAngle);
            dial.transform = CGAffineTransformMakeRotation(currentAngle - previousAngle);  // 40/(2*pi) = 6.36619772

            lastTouch1 = touch1;
            lastTouch2 = touch2;
        
        
    }
}
*/
-(IBAction)tapDial:(id)sender
{
        switch (numberInSequence) {
           case 0:
                firstNumberEntered = dialAcc;
                #if TARGET_IPHONE_SIMULATOR
                NSLog(@"Simulator Entry");
                firstNumberEntered = slider.value;
                #endif
                [self animateNumber:firstNumberEntered];
                numberInSequence++;
                pageControl.currentPage = 1;
                break;
            case 1:
                secondNumberEntered = dialAcc;
                #if TARGET_IPHONE_SIMULATOR
                secondNumberEntered = slider.value;
                #endif
                [self animateNumber:secondNumberEntered];
                numberInSequence++;
                pageControl.currentPage = 2;
                break;
            case 2:
                thirdNumberEntered = dialAcc;
                #if TARGET_IPHONE_SIMULATOR
                thirdNumberEntered = slider.value;
                #endif
                [self animateNumber:thirdNumberEntered];
                pageControl.currentPage = 0;

                if (
                    (firstNumberEntered == [myComboManager getComboNumber:1]) &&
                    (secondNumberEntered == [myComboManager getComboNumber:2]) &&
                    (thirdNumberEntered == [myComboManager getComboNumber:3])){
                    
                    NSLog(@"Correct!");

                    myPasswordViewController = [[PasswordViewController alloc]
                                                                        initWithNibName:@"PasswordViewController"
                                                                        bundle:nil];
                    [UIView beginAnimations:@"flipview" context:nil];
                    [UIView setAnimationDuration:2];
                    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
                    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
                        
                        [self.view addSubview:myPasswordViewController.view];
                    
                    [UIView commitAnimations];
                }
                else{
                    numberLabel.text = @"WRONG";
                    numberLabel.alpha = 0.0;
                    [self animateWrong];

                    [UIView beginAnimations:nil context:NULL];
                    [UIView setAnimationDuration:0.3];
                    [UIView setAnimationDelegate:self];
                    [UIView setAnimationDidStopSelector:@selector(animation:finished:context:)];
                    
                    numberLabel.transform  = CGAffineTransformMakeScale(3.0f, 3.0f);
                    numberLabel.alpha = .8;
                    [UIView commitAnimations];
                    
                }
                numberInSequence = 0;
                break;
            default:
                firstNumberEntered = (int)slider.value;
                [self animateNumber:firstNumberEntered];
                numberInSequence = 1;
                break;
        }
}

-(IBAction)byPass:(id)sender{
    numberLabel.text = [NSString stringWithFormat:@"%i - %i - %i",
                        [myComboManager getComboNumber:1],
                        [myComboManager getComboNumber:2],
                        [myComboManager getComboNumber:3]];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    
    numberLabel.transform  = CGAffineTransformMakeScale(3.0f, 3.0f);
    numberLabel.alpha = .8;
    
    [UIView commitAnimations];
}

-(void)animateNumber:(int) number;
{
    numberLabel.text = [NSString stringWithFormat:@"%i", number];
    numberLabel.alpha = 0.0;

    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationHasFinished:finished:context:)];
    
    numberLabel.transform  = CGAffineTransformMakeScale(3.0f, 3.0f);
    numberLabel.alpha = .8;
    
    [UIView commitAnimations];

}

- (void)animationHasFinished:(NSString *)animationID finished:(BOOL)finished context:(void *)context
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
        numberLabel.transform  = CGAffineTransformMakeScale(0.5f, 0.5f);
        numberLabel.alpha = 0.0;
    [UIView commitAnimations];
}

-(void) animateWrong
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.15];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationWrongHasFinished:finished:context:)];
        lockLoop.transform = CGAffineTransformMakeTranslation(0, +10.0);    
    [UIView commitAnimations];
}


-(void)animationWrongHasFinished:(NSString *)animationID finished:(BOOL)finished context:(void *)context
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.15];
        lockLoop.transform = CGAffineTransformMakeTranslation(0, -0.0);    
    [UIView commitAnimations];
}


- (void)dealloc
{
    [myPasswordViewController release];
    [slider release];
    [dial dealloc];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    /*
    motionManager = [[[CMMotionManager alloc] init]autorelease];
    motionManager.deviceMotionUpdateInterval = 1/60;
    if (motionManager.isDeviceMotionAvailable) {
        [motionManager startDeviceMotionUpdates];
    }
    */    
    UIAccelerometer *accel = [UIAccelerometer sharedAccelerometer];
    accel.delegate = self;
    accel.updateInterval = 1/60;
    myComboManager = [ComboManager sharedSingleton];

    path = [[NSBundle mainBundle]pathForResource:@"tink" ofType:@"aiff"];
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:nil];
    pageControl.numberOfPages = 3;
    [audioPlayer prepareToPlay];

    [super viewDidLoad];
}


- (void)viewDidUnload
{

    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
