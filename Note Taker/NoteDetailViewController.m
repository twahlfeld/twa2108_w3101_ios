//
//  NoteDetailViewController.m
//  Note Taker
//
//  Created by Theodore Ahlfeld on 10/22/14.
//  Copyright (c) 2014 Theodore Ahlfeld. All rights reserved.
//

#import "NoteDetailViewController.h"

@interface NoteDetailViewController ()

@property (weak, nonatomic) IBOutlet UITextField *noteTitle;
@property (weak, nonatomic) IBOutlet UITextView *noteText;
@property (weak, nonatomic) IBOutlet UIImageView *noteImageView;

@end

@implementation NoteDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavigationButtons];
    if(self.thisNote != nil) {
        self.noteTitle.text = [self.thisNote noteTitle];
        self.noteText.text = [self.thisNote noteText];
        self.noteImageView.image = [self.thisNote noteImage];
    }
}



- (void)setUpNavigationButtons {
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *cameraBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(pickImageSource:)];
    UIBarButtonItem *shareBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(emailNote:)];
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:shareBarButton, cameraBarButton, nil] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ImageView

- (IBAction)pickImageSource:(UIBarButtonItem *)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Photo Source"
                                                    message:@"Select the Photo Source"
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Photo Library", @"Take Photo", nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1) {
        [self pickImageFromLibrary:YES];
    } else if (buttonIndex == 2) {
        [self pickImageFromLibrary:NO];
        
    }
}

- (void)pickImageFromLibrary: (BOOL)pickedFromLibrary {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    if(pickedFromLibrary == YES) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    } else {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        } else {
            UIAlertView *noCameraAlert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                    message:@"Device has no camera"
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles: nil];
            
            [noCameraAlert show];
            return;
        }
    }
    [self presentViewController:imagePicker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.noteImageView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - MFMailComposeDelegate

- (IBAction)emailNote:(id)sender {
    if ([MFMailComposeViewController canSendMail]) {
        
        MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
        mailViewController.mailComposeDelegate = self;
        
        NSString *messageSubject;
        NSString *messageBody;
        
        NSData *imageData = UIImageJPEGRepresentation(self.noteImageView.image, 1);
        [mailViewController addAttachmentData:imageData mimeType:@"image/jpeg" fileName:@"NoteAttachment.jpg"];
        
        [mailViewController setSubject:messageSubject];
        [mailViewController setMessageBody:messageBody isHTML:NO];
        
        [self.navigationController presentViewController:mailViewController animated:YES completion:nil];
        
    }
    else {
        
        NSLog(@"Device is unable to send email in its current state.");
        
    }
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

-(void)viewWillDisappear:(BOOL)animated
{
    if(![self.noteTitle isEqual:@""]) {
        NoteList *listOfNotes = [NoteList noteSingleton];
        if(self.thisNote == nil) {
            [listOfNotes addNoteToNoteList:self.noteTitle.text noteBody:self.noteText.text image:self.noteImageView.image time:[NSDate date]];
        } else {
            [self.thisNote setNoteTitle:self.noteTitle.text];
            [self.thisNote setNoteText:self.noteText.text];
            [self.thisNote setNoteImage:self.noteImageView.image];
        }
        [listOfNotes saveNotes];
    }
}


@end
