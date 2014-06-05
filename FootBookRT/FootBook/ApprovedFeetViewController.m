//
//  ApprovedFeetViewController.m
//  FootBook
//
//  Created by Ryan Tiltz on 6/4/14.
//  Copyright (c) 2014 Ryan Tiltz. All rights reserved.
//

#import "ApprovedFeetViewController.h"
#import "ProfileViewController.h"
#import "Person.h"
#import "Comment.h"
#import "Photo.h"

@interface ApprovedFeetViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *approvedFeetArray;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation ApprovedFeetViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    self.approvedFeetArray = [NSMutableArray new];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self load];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.approvedFeetArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellReuseID"];
    Person *person = self.approvedFeetArray[indexPath.row];
    cell.textLabel.text = person.name;
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu comments",(unsigned long)[person.comment count]];
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell *)sender
{
    ProfileViewController *destination = segue.destinationViewController;
    NSIndexPath *indexPath = [self.myTableView indexPathForCell:sender];
    Person *person = self.approvedFeetArray[indexPath.row];
    destination.person = person;
    destination.managedObjectContext = self.managedObjectContext;
}

-(void)load
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Person"];
    NSArray *tempArray = (id)[self.managedObjectContext executeFetchRequest:request error:nil];
    for (Person *person in tempArray)
    {
        if (person.isFriend && ![self.approvedFeetArray containsObject:person])
        {
            [self.approvedFeetArray addObject:person];
        }
    }
    [self.myTableView reloadData];
}



@end
