//
//  Person.h
//  FootBook
//
//  Created by Ryan Tiltz on 6/4/14.
//  Copyright (c) 2014 Ryan Tiltz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Comment, Photo;

@interface Person : NSManagedObject

@property (nonatomic, retain) NSSet *comment;
@property (nonatomic, retain) NSNumber * shoeSize;
@property (nonatomic, retain) NSNumber * width;
@property (nonatomic, retain) NSString * smell;
@property (nonatomic, retain) NSNumber * isFriend;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * numberOfFeet;
@property (nonatomic, retain) Photo *photo;
@end

@interface Person (CoreDataGeneratedAccessors)

- (void)addCommentObject:(Comment *)value;
- (void)removeCommentObject:(Comment *)value;
- (void)addComment:(NSSet *)values;
- (void)removeComment:(NSSet *)values;

@end
