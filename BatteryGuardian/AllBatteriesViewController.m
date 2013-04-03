//
//  AllBatteriesViewController.m
//  BatteryGuardian
//
//  Created by brian on 3/17/13.
//
//

#import "AllBatteriesViewController.h"
#import "BatteryGuardianAppDelegate.h"
#import "BatteryInfo.h"
#import "AddEditBatteryViewController.h"

@interface AllBatteriesViewController ()

@end

@implementation AllBatteriesViewController

@synthesize managedObjectContext;
@synthesize batteryInfos;
@synthesize tableViewController;
@synthesize addButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    managedObjectContext = [[BatteryGuardianContext alloc] init].managedObjectContext;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"BatteryInfo" inManagedObjectContext:managedObjectContext];
    
    [fetchRequest setEntity: entity];
    NSError *error;
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addEvent)];
    addButton.enabled = YES;
    self.navigationItem.rightBarButtonItem = self.addButton;
    
    batteryInfos = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (int) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [batteryInfos count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc ] init];
    [dateFormater setDateFormat:@"dd-MM-YYYY"];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    BatteryInfo *bi = [batteryInfos objectAtIndex: [indexPath row]];
    cell.textLabel.text = [NSString stringWithFormat: @"%@", bi.batteryDescription];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Last Charged: %@   ", [dateFormater stringFromDate:bi.lastChargedDate]];
    //cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    /*
     When a row is selected, the segue creates the detail view controller as the destination.
     Set the detail view controller's detail item to the item associated with the selected row.
     */
    //if ([[segue identifier] isEqualToString:@"ShowSelectedPlay"]) {
        
    NSIndexPath *selectedRowIndex = [self.tableView indexPathForSelectedRow];
    AddEditBatteryViewController *detailViewController = [segue destinationViewController];
    BatteryInfo *bi = [batteryInfos objectAtIndex:selectedRowIndex.row];
    detailViewController.batteryName = bi.name;

}

/*
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    /*
     [tableView deselectRowAtIndexPath:indexPath animated:NO];
     BATTrailsViewController *trailsController = [[BATTrailsViewController alloc] initWithStyle:UITableViewStylePlain];
     trailsController.selectedRegion = [regions objectAtIndex:indexPath.row];
     [[self navigationController] pushViewController:trailsController animated:YES];
     [trailsController release];
     *
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    AddEditBatteryViewController* addEditViewController = [[AddEditBatteryViewController alloc] initWithNibName:<#(NSString *)#> bundle:<#(NSBundle *)#>];
    
    [[self navigationController] pushViewController:addEditViewController animated:YES];
    
}
*/
@end
