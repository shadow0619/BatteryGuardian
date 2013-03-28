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
    
    BatteryGuardianAppDelegate *ad = [BatteryGuardianAppDelegate sharedAppDelegate];
    
    managedObjectContext = ad.managedObjectContext;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"BatteryInfo" inManagedObjectContext:managedObjectContext];
    

    
    [fetchRequest setEntity: entity];
    NSError *error;
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addEvent)];
    addButton.enabled = NO;
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
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    return cell;
}

@end
