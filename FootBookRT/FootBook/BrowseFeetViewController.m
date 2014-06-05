//
//  BrowseFeetViewController.m
//  FootBook
//
//  Created by Ryan Tiltz on 6/4/14.
//  Copyright (c) Ryan Tiltz. All rights reserved.
//

#import "BrowseFeetViewController.h"
#import "Person.h"
#import "ProfileViewController.h"

@interface BrowseFeetViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) NSMutableArray *browseFeetArray;

@end

@implementation BrowseFeetViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.browseFeetArray = [NSMutableArray new];
    [self load];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.browseFeetArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Person *person = self.browseFeetArray[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text = person.name;
    
        return cell;
}

-(void)load
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Person"];
    self.browseFeetArray = (id)[self.managedObjectContext executeFetchRequest:request error:nil];

    if (!self.browseFeetArray.count > 0)
    {
        NSArray *smellArray = @[@"Roses",
                                 @"Fungus",
                                 @"Trash Can",
                                 @"Dog Feces",
                                 @"Fishy",
                                 @"GoldBond Powder",
                                 @"Delicious"];
        
        NSURL *url = [NSURL URLWithString:@"http://s3.amazonaws.com/mobile-makers-assets/app/public/ckeditor_assets/attachments/4/friends.json"];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
        {
            NSArray *tempArray = [NSJSONSerialization JSONObjectWithData:data
                                                                   options:NSJSONReadingAllowFragments
                                                                     error:&connectionError];
            for (NSString *personName in tempArray)
            {
                Person *person = [NSEntityDescription insertNewObjectForEntityForName:@"Person"
                                                               inManagedObjectContext:self.managedObjectContext];

                person.name = personName;
                person.shoeSize = @(arc4random()%20+1);
                person.width = @(arc4random()%4+1);
                person.smell = smellArray[arc4random()%[smellArray count]];
                person.numberOfFeet = @(arc4random()%6+1);
                person.isFriend = NO;
            }
            [self.managedObjectContext save:nil];
            [self load];
        }];
    }
    [self.myTableView reloadData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell *)sender
{
    ProfileViewController *destination = segue.destinationViewController;
    NSIndexPath *indexPath = [self.myTableView indexPathForCell:sender];
    Person *person = self.browseFeetArray[indexPath.row];
    destination.person = person;
    destination.managedObjectContext = self.managedObjectContext;
}


@end
