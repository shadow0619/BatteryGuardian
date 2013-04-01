//
//  AddEditBatteryViewController.m
//  BatteryGuardian
//
//  Created by brian on 3/17/13.
//
//

#import "AddEditBatteryViewController.h"
#import "MessageCenter.h"
#import "BatteryGuardianAppDelegate.h"
#import "BatteryInfo.h"

@interface AddEditBatteryViewController ()

@property (weak, nonatomic) IBOutlet UILabel *lblBatteryName;
@property (weak, nonatomic) IBOutlet UITextField *txtBatteryDesc;
@property (weak, nonatomic) IBOutlet UILabel *lblLastTimeCharged;


@end

@implementation AddEditBatteryViewController


- (IBAction)cmdCharged_clicked:(id)sender
{
    
    
    //Set a new notification
    MessageCenter *msg = [[MessageCenter alloc]init];
    [msg batteryCharge:self.lblBatteryName.text];
    
    
}

-(void) viewDidLoad
{
    [super viewDidLoad];
    
    //Set the value passed from the previous view
    self.lblBatteryName.text = self.batteryName;
    
    //create a fetch request for the batteryinfo for the selected item
    BatteryGuardianAppDelegate *del = [BatteryGuardianAppDelegate sharedAppDelegate];
    NSManagedObjectContext *context = del.managedObjectContext;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"BatteryInfo" inManagedObjectContext:context];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name=%@",self.batteryName];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setEntity:entity];
    
    //execute the fetch
    NSError *err;
    NSArray *batteryInfos = [context executeFetchRequest:fetchRequest error:&err];
    for(BatteryInfo *bi in batteryInfos)
    {
        self.lblLastTimeCharged.text = [NSString stringWithFormat:@"%@",bi.lastChargedDate];
        self.txtBatteryDesc.text = bi.batteryDescription;
    }
    
}
@end