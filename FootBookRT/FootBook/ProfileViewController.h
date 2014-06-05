//
//  ProfileViewController.h
//  FootBook
//
//  Created by Ryan Tiltz on 6/4/14.
//  Copyright (c) 2014 Ryan Tiltz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"

@interface ProfileViewController : UIViewController

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) Person *person;

@end
