//
//  Comment.h
//  FootBook
//
//  Created by Ryan Tiltz on 6/4/14.
//  Copyright (c) 2014 Ryan Tiltz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Person;

@interface Comment : NSManagedObject

@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) Person *person;

@end
