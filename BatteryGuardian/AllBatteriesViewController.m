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
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSArray *batteryInfos;
@property (weak, nonatomic) IBOutlet UITableView *tableViewController;
@property (nonatomic, retain) UIBarButtonItem *addButton;
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
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    [super viewDidLoad];
    [self updateTable];
}

-(void) viewWillAppear:(BOOL)animated
{
    [self updateTable];
    [self.tableViewController reloadData];
}

-(void) updateTable
{
    // Do any additional setup after loading the view.
    
    managedObjectContext = [[BatteryGuardianContext alloc] init].managedObjectContext;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"BatteryInfo" inManagedObjectContext:managedObjectContext];
    
    [fetchRequest setEntity: entity];
    NSError *error;
    
    batteryInfos = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSManagedObject *obj = [batteryInfos objectAtIndex:indexPath.row];
        [self.managedObjectContext deleteObject:obj];
        NSError *err;
        if(![self.managedObjectContext save:&err])
        {
            NSLog(@"Whoops, couldn't save: %@", [err localizedDescription]);
        }
        
        [self updateTable];
    
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationTop];
    }
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
    if ([[segue identifier] isEqualToString:@"edit"])
    {
        
    NSIndexPath *selectedRowIndex = [self.tableView indexPathForSelectedRow];
    AddEditBatteryViewController *detailViewController = [segue destinationViewController];
    BatteryInfo *bi = [batteryInfos objectAtIndex:selectedRowIndex.row];
    detailViewController.batteryName = bi.name;
    }else if ([[segue identifier] isEqualToString:@"add"])
    {
        AddEditBatteryViewController *detailViewController = [segue destinationViewController];
        detailViewController.isAdd = YES;
    }
}


-(void) addEvent: sender
{	
    AddEditBatteryViewController *addEdit = [[AddEditBatteryViewController alloc]init];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:addEdit];
    
    [[self navigationController] presentViewController:nav animated:YES completion:nil];
    
}
@end
