//
//  NoteDetailViewController.h
//  Note Taker
//
//  Created by Theodore Ahlfeld on 10/22/14.
//  Copyright (c) 2014 Theodore Ahlfeld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface NoteDetailViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIAlertViewDelegate, MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *noteTitle;
@property (weak, nonatomic) IBOutlet UITextView *noteText;
@property (weak, nonatomic) IBOutlet UIImageView *noteImageView;

@end
