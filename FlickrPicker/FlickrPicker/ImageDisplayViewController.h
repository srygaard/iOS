//
//  ImageDisplayViewController.h
//  PhotoPickerII
//
//  Created by MLIB116M66 on 10/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "ImageDisplayInfo.h"

@interface ImageDisplayViewController : UIViewController <UIScrollViewDelegate, UIActionSheetDelegate, MFMailComposeViewControllerDelegate> {
    IBOutlet UIImageView *imageDisplay;
    UIScrollView *imageScroll;
    ImageDisplayInfo *imageDisplayInfo;
    NSString *URL;
    UIBarButtonItem *emailButton;
    UIImage * image;
    IBOutlet UIToolbar *toolBar;
}
- (IBAction) emailButtonClicked:(id)sender;
- (void) showEmailModalView;

@end
