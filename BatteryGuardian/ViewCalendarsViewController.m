//
//  ViewCalendarsViewController.m
//  BatteryGuardian
//
//  Created by Brian Picard on 4/6/13.
//
//
#import <EventKit/EventKit.h>
#import "ViewCalendarsViewController.h"

@interface ViewCalendarsViewController ()

@property (nonatomic, strong) NSArray *calendarEntries;

@end

@implementation ViewCalendarsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [super viewDidLoad];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //Set the future date, calendar, Predicate and finally fill the array to use for the controller
    EKEventStore *eventStore = [[EKEventStore alloc]init];
    NSDateComponents *comp = [[NSDateComponents alloc]init];
    comp.day = -1;
    NSDate *startDate = [calendar dateByAddingComponents:comp toDate:[NSDate date]options:0];
    comp.year = 1;
    NSDate *endDate = [calendar dateByAddingComponents:comp toDate:[NSDate date] options:0];
    NSPredicate *pred = [eventStore predicateForEventsWithStartDate:startDate endDate:endDate calendars:nil];
    self.calendarEntries = [eventStore eventsMatchingPredicate:pred];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.calendarEntries count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    EKEvent *event = [self.calendarEntries objectAtIndex:[indexPath row]];
    
    cell.textLabel.text = event.title;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",event.startDate];
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
