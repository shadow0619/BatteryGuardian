//
//  AddEditBatteryViewController.m
//  BatteryGuardian
//
//  Created by brian on 3/17/13.
//
//

#import "AddEditBatteryViewController.h"
#import "MessageCenter.h"

@implementation AddEditBatteryViewController

-(void) viewDidLoad
{
    [super viewDidLoad];
    
    //Move this to a button click for charing a battery
    MessageCenter *msg = [[MessageCenter alloc]init];
    [msg batteryCharge:@"Battery1"];
}
@end