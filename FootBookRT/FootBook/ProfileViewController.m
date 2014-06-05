//
//  ProfileViewController.m
//  FootBook
//
//  Created by Ryan Tiltz on 6/4/14.
//  Copyright (c) 2014 Ryan Tiltz. All rights reserved.
//

#import "ProfileViewController.h"
#import "Comment.h"
#import "Photo.h"

@interface ProfileViewController ()
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *numberOfFeetLabel;
@property (strong, nonatomic) IBOutlet UILabel *widthLabel;
@property (strong, nonatomic) IBOutlet UILabel *shoeSizeLabel;
@property (strong, nonatomic) IBOutlet UILabel *smellLabel;
@property (strong, nonatomic) IBOutlet UITextField *commentTextField;
@property (strong, nonatomic) IBOutlet UITextView *commentTextView;
@property (strong, nonatomic) IBOutlet UIImageView *myImageView;
@end

@implementation ProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.nameLabel.text = [NSString stringWithFormat:@"%@",self.person.name];
    self.numberOfFeetLabel.text = [NSString stringWithFormat:@"Number of Feet: %@",self.person.numberOfFeet];
    self.shoeSizeLabel.text = [NSString stringWithFormat:@"Shoe Size: %@",self.person.shoeSize];
    self.widthLabel.text = [NSString stringWithFormat:@"Width: %@",self.person.width];
    self.smellLabel.text = [NSString stringWithFormat:@"Smell: %@",self.person.smell];

    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Photo"];
    NSArray *testArray = [self.managedObjectContext executeFetchRequest:request error:nil];
    Photo *photo = testArray.firstObject;
    self.myImageView.image = [UIImage imageWithData:photo.imageData];
    [self loadComments];
}

- (void)loadComments
{
    if (self.person.comment) {
        NSLog(@"%@",self.person.comment);
        self.commentTextView.text = @"";
        
        for (Comment *comment in self.person.comment) {
            NSLog(@"%@",comment.text);
            self.commentTextView.text = [NSString stringWithFormat:@"%@\n%@",self.commentTextView.text,comment.text];
        }
    }
}

#pragma mark -- IBAction methods

- (IBAction)onApprovedFeetAddButtonPressed:(UIBarButtonItem *)sender
{
    sender.enabled = NO;
    self.person.isFriend = [NSNumber numberWithBool:YES];
    NSLog(@"%@", self.person.isFriend);
    [self.managedObjectContext save:nil];
}

- (IBAction)commentTextFieldDidEnd:(id)sender
{
    [self enterComment];
}

- (IBAction)onCommentButtonPressed:(id)sender
{
    [self enterComment];
}

-  (void)enterComment
{
    Comment *comment = [NSEntityDescription insertNewObjectForEntityForName:@"Comment" inManagedObjectContext:self.managedObjectContext];
    comment.text = self.commentTextField.text;
    
    self.commentTextField.text = @"";
    [self.commentTextField endEditing:YES];
    
    [self.person addCommentObject:comment];
    
    [self.managedObjectContext save:nil];
    [self loadComments];
}
@end
